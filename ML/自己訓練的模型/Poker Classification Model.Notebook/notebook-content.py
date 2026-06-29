# Fabric notebook source

# METADATA ********************

# META {
# META   "kernel_info": {
# META     "name": "synapse_pyspark"
# META   },
# META   "dependencies": {
# META     "lakehouse": {
# META       "default_lakehouse": "7690a096-a861-4c15-8740-945d31b9061f",
# META       "default_lakehouse_name": "ML_Poker_Classification",
# META       "default_lakehouse_workspace_id": "f42c5981-42e2-4f68-9985-cf204aaab82c",
# META       "known_lakehouses": [
# META         {
# META           "id": "7690a096-a861-4c15-8740-945d31b9061f"
# META         }
# META       ]
# META     }
# META   }
# META }

# CELL ********************

%pip install torchvision
%pip install --upgrade pip
%pip install "protobuf==3.20.3" "mlflow==2.10.2" --force-reinstall

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

import os
import torch
import torch.nn as nn
import torch.optim as optim
from torchvision import datasets, models, transforms
from torch.utils.data import DataLoader
import mlflow
import mlflow.pytorch

# --- 1. Environment & Path Discovery ---
data_dir = '/lakehouse/default/Files'
if not os.path.exists(data_dir):
    data_dir = './Files' 

required_folders = ['train', 'valid']
paths = {}

for subdir in required_folders:
    actual_dir = next((d for d in os.listdir(data_dir) if d.lower() == subdir), None)
    if actual_dir:
        paths[subdir] = os.path.join(data_dir, actual_dir)
    else:
        raise FileNotFoundError(f"Missing '{subdir}' in {data_dir}")

# --- 2. Data Preparation ---
data_transforms = {
    'train': transforms.Compose([
        transforms.RandomResizedCrop(224),
        transforms.RandomHorizontalFlip(),
        transforms.ToTensor(),
        transforms.Normalize([0.485, 0.456, 0.406], [0.229, 0.224, 0.225])
    ]),
    'valid': transforms.Compose([
        transforms.Resize(256),
        transforms.CenterCrop(224),
        transforms.ToTensor(),
        transforms.Normalize([0.485, 0.456, 0.406], [0.229, 0.224, 0.225])
    ]),
}

image_datasets = {x: datasets.ImageFolder(paths[x], data_transforms[x]) for x in ['train', 'valid']}
dataset_sizes = {x: len(image_datasets[x]) for x in ['train', 'valid']}
class_names = image_datasets['train'].classes
device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")

# --- 3. Model & Training Logic ---
def initialize_poker_model(num_classes):
    model = models.resnet18(pretrained=True)
    num_ftrs = model.fc.in_features
    model.fc = nn.Linear(num_ftrs, num_classes)
    return model.to(device)

def train_and_log(lr, epochs, batch_size):
    # Initialize Experiment
    mlflow.set_experiment("Poker_Card_Classification")
    
    # Create DataLoader with current batch_size
    dataloaders = {x: DataLoader(image_datasets[x], batch_size=batch_size, shuffle=True) 
                   for x in ['train', 'valid']}
    
    # Initialize Model, Criterion, and Optimizer
    model = initialize_poker_model(len(class_names))
    criterion = nn.CrossEntropyLoss()
    optimizer = optim.Adam(model.parameters(), lr=lr)

    with mlflow.start_run(run_name=f"Run_LR_{lr}_BS_{batch_size}") as run:
        # Log Parameters
        mlflow.log_params({
            "learning_rate": lr,
            "num_epochs": epochs,
            "batch_size": batch_size,
            "model_type": "ResNet18"
        })

        best_acc = 0.0

        for epoch in range(epochs):
            print(f'Epoch {epoch}/{epochs - 1}')
            
            for phase in ['train', 'valid']:
                if phase == 'train':
                    model.train()
                else:
                    model.eval()

                running_loss = 0.0
                running_corrects = 0

                for inputs, labels in dataloaders[phase]:
                    inputs, labels = inputs.to(device), labels.to(device)
                    optimizer.zero_grad(set_to_none=True)

                    with torch.set_grad_enabled(phase == 'train'):
                        outputs = model(inputs)
                        _, preds = torch.max(outputs, 1)
                        loss = criterion(outputs, labels)

                        if phase == 'train':
                            loss.backward()
                            optimizer.step()

                    running_loss += loss.item() * inputs.size(0)
                    running_corrects += torch.sum(preds == labels.data)

                epoch_loss = running_loss / dataset_sizes[phase]
                epoch_acc = running_corrects.double() / dataset_sizes[phase]

                # Log metrics per epoch
                mlflow.log_metric(f"{phase}_loss", epoch_loss, step=epoch)
                mlflow.log_metric(f"{phase}_acc", float(epoch_acc), step=epoch)
                
                print(f'{phase} Loss: {epoch_loss:.4f} Acc: {epoch_acc:.4f}')
                
                # Keep track of the final results for the summary
                final_accuracy = float(epoch_acc)
                final_loss = epoch_loss

        # --- LOG FINAL RESULTS ---
        mlflow.log_metric("final_accuracy", final_accuracy)
        mlflow.log_metric("final_loss", final_loss)

        # --- SAVE THE MODEL ARTIFACT ---
        mlflow.pytorch.log_model(
            pytorch_model=model, 
            artifact_path="poker-model-artifacts",
            registered_model_name="Poker_Card_Model"
        )
        
        print(f"\n✅ Run Complete!")
        print(f"Run ID: {run.info.run_id}")
        print(f"Registered Model Name: Poker_Card_Model")

# --- 4. Execution ---
# You can now run multiple experiments just by changing these values
train_and_log(lr=0.001, epochs=3, batch_size=32)

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }
