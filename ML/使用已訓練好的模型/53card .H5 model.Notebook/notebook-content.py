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
# META     },
# META     "environment": {
# META       "environmentId": "438c35f6-5a3a-43f7-94bc-1c1a9a16d1e3",
# META       "workspaceId": "2725871c-d107-4d01-9929-3e1f545e892d"
# META     }
# META   }
# META }

# MARKDOWN ********************

# ### 安裝需要的library來讀取模型

# CELL ********************

%pip uninstall protobuf tensorflow mlflow -y
%pip install "protobuf==3.20.3" "tensorflow==2.15.0" "mlflow==2.10.2" --force-reinstall


# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark",
# META   "frozen": false,
# META   "editable": true
# META }

# MARKDOWN ********************

# ### 讀取存在Lakehouse File Folder 的模型

# CELL ********************

import os
import numpy as np
import tensorflow as tf
from tensorflow.keras.models import load_model
from tensorflow.keras.layers import DepthwiseConv2D

# --- 1. 定義修正版的 Layer ---
# 這是為了處理 MobileNet 或部分模型在不同 TF 版本間 groups 參數不相容的問題
class FixedDepthwiseConv2D(DepthwiseConv2D):
    def __init__(self, **kwargs):
        if 'groups' in kwargs:
            kwargs.pop('groups') 
        super().__init__(**kwargs)

# --- 2. 設定路徑 ---
fabric_path = "/lakehouse/default/Files/53cards-53-(200 X 200)-100.00.h5"

# --- 3. 載入模型邏輯 ---
if os.path.exists(fabric_path):
    print(f"✅ 檔案存在，準備載入: {fabric_path}")
    
    try:
        # 使用 custom_objects 來攔截並修正 DepthwiseConv2D 的初始化
        model = load_model(
            fabric_path, 
            custom_objects={'DepthwiseConv2D': FixedDepthwiseConv2D},
            compile=False # 建議設為 False，除非你需要繼續訓練
        )
        print("🎉 模型載入成功！")
        
        # --- 4. 測試預測 ---
        # 根據你的模型設定 (200x200)
        img_size = 200
        dummy_input = np.random.rand(1, img_size, img_size, 3).astype(np.float32)
        
        print(f"正在使用隨機數據測試 (Shape: {dummy_input.shape})...")
        prediction = model.predict(dummy_input, verbose=0)
        
        print(f"預測輸出類別數量: {prediction.shape[1]}")
        print(f"最高機率類別索引: {np.argmax(prediction)}")
        
    except Exception as e:
        # 如果還是報 runtime_version 錯誤，代表 Session 沒有重啟成功
        print(f"❌ 載入失敗。錯誤訊息: {e}")
        if "runtime_version" in str(e):
            print("💡 提示：這依然是 Protobuf 版本衝突，請確認已執行 %pip 並『重啟 Session』。")
else:
    print(f"❌ 找不到模型檔案: {fabric_path}")

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# MARKDOWN ********************

# ### 使用已訓練好的模型做圖像辨識 - 從單一圖檔路徑

# CELL ********************

import os
import numpy as np
import matplotlib.pyplot as plt
from tensorflow.keras.preprocessing import image

# --- 自動抓取類別名稱 (Auto-detect class names) ---
# 設定你的測試資料夾根目錄 (根據你提供的路徑推算)
base_dir = "/lakehouse/default/Files/test/" 

# 檢查資料夾是否存在
if os.path.exists(base_dir):
    # 1. 讀取該目錄下的所有子資料夾名稱
    # 2. 過濾掉不是資料夾的項目
    # 3. 進行排序 (sorted) -> 非常重要！因為 Keras 訓練時是依字母順序排列的
    class_names = sorted([d for d in os.listdir(base_dir) if os.path.isdir(os.path.join(base_dir, d))])
    
    print(f"✅ 自動偵測到 {len(class_names)} 個類別：")
    print(class_names)
else:
    print("❌ 找不到測試資料夾，無法自動抓取名稱。請手動輸入。")
    # 如果找不到資料夾，這裡放一個備用的空清單或手動清單
    class_names = [] 

# -------------------------------------------------------

# 2. 設定你要測試的圖片路徑
test_image_path = "/lakehouse/default/Files/valid/two of clubs/2.jpg" 

# 3. 執行預測邏輯
if os.path.exists(test_image_path):
    print(f"\n✅ 找到圖片：{test_image_path}")
    
    # --- 處理圖片 ---
    img = image.load_img(test_image_path, target_size=(200, 200))
    img_array = image.img_to_array(img)
    img_array = np.expand_dims(img_array, axis=0) 
    # img_array = img_array / 255.0 
    
    # print(img_array)


    # --- 預測 ---
    if 'model' in locals():
        predictions = model.predict(img_array)
        predicted_class_index = np.argmax(predictions)
        confidence = np.max(predictions) * 100
        
        # --- 取得名稱 ---
        # 確保 index 沒有超出我們剛剛自動抓到的清單範圍
        if predicted_class_index < len(class_names):
            label_name = class_names[predicted_class_index]
        else:
            label_name = f"Unknown Class (Index {predicted_class_index})"

        # --- 顯示結果 ---
        print(f"\n結果: {label_name}")
        print(f"信心水準: {confidence:.2f}%")
        
        plt.imshow(img)
        plt.axis('off')
        plt.title(f"Prediction: {label_name}\n({confidence:.1f}%)")
        plt.show()
        
    else:
        print("❌ 錯誤：變數 'model' 不存在。請先執行載入模型的步驟。")

else:
    print(f"❌ 錯誤：找不到圖片檔案。")

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# MARKDOWN ********************

# ### 使用已訓練好的模型做圖像辨識 - 全部在資料夾裡的檔案

# MARKDOWN ********************

# ### 

# CELL ********************

import os
import pandas as pd
import numpy as np
from tensorflow.keras.preprocessing import image

# 1. 設定測試資料夾的路徑
base_dir = "/lakehouse/default/Files/test/"

# 2. 自動偵測類別名稱
if os.path.exists(base_dir):
    class_names = sorted([d for d in os.listdir(base_dir) if os.path.isdir(os.path.join(base_dir, d))])
    print(f"✅ 偵測到類別: {class_names}")
else:
    print("❌ 找不到資料夾")
    class_names = []

results = []

if 'model' in locals():
    print("🚀 開始批量預測...")
    
    for root, dirs, files in os.walk(base_dir):
        for file in files:
            if file.lower().endswith(('.png', '.jpg', '.jpeg')):
                img_path = os.path.join(root, file)
                actual_label = os.path.basename(root) 
                
                try:
                    # --- 圖片前處理 ---
                    img = image.load_img(img_path, target_size=(200, 200))
                    img_array = image.img_to_array(img)
                    img_array = np.expand_dims(img_array, axis=0)
                    
                    # --- 預測 ---
                    predictions = model.predict(img_array, verbose=0)
                    predicted_index = np.argmax(predictions)
                    confidence = np.max(predictions) * 100
                    
                    if predicted_index < len(class_names):
                        predicted_label = class_names[predicted_index]
                    else:
                        predicted_label = f"Unknown ({predicted_index})"
                    
                    # --- 修改重點：將判斷結果轉為整數 1 或 0 ---
                    is_correct_val = int(actual_label == predicted_label)
                    
                    results.append({
                        "Folder_Name": actual_label,
                        "Filename": file,
                        "Predicted_Label": predicted_label,
                        "Confidence": round(confidence, 2),
                        "Is_Correct": is_correct_val  # 這裡會儲存為 1 或 0
                    })
                    
                except Exception as e:
                    print(f"⚠️ 無法讀取檔案 {file}: {e}")

    # 4. 轉成 DataFrame 表格
    df_results = pd.DataFrame(results)
    
    # 額外確保型別為整數 (避免有些版本會自動轉回布林)
    if not df_results.empty:
        df_results['Is_Correct'] = df_results['Is_Correct'].astype(int)

    # 5. 顯示結果
    print(f"\n✅ 測試完成！共測試 {len(df_results)} 張圖片。")
    
    if len(df_results) > 0:
        # 在 1/0 模式下，mean() 依然可以直接計算出準確率
        accuracy = df_results['Is_Correct'].mean() * 100
        print(f"🏆 整體準確率 (Accuracy): {accuracy:.2f}%")
        display(df_results.head(10))
    else:
        print("沒有找到任何圖片。")
else:
    print("❌ 變數 'model' 不存在，請先載入模型。")

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# MARKDOWN ********************

# ## 把預判結果存成一個parquet檔案

# CELL ********************

import os
import pandas as pd
from datetime import datetime
import pytz  # 導入時區處理庫

# 1. 設定台灣時區 (UTC +8)
taipei_tz = pytz.timezone('Asia/Taipei')
# 取得台北當前時間並格式化
timestamp = datetime.now(taipei_tz).strftime("%Y%m%d_%H%M%S")

# 2. 定義包含時間戳記的檔名
# 格式：prediction_results_20260318_164006.parquet
file_name = f"prediction_results_{timestamp}.parquet"
file_path = f"/lakehouse/default/Files/Prediction_logs/{file_name}"

# 3. 確保父目錄存在 (Files 區段的非管理路徑)
parent_dir = os.path.dirname(file_path)
os.makedirs(parent_dir, exist_ok=True)

# 4. 直接寫入 Lakehouse 的 Files 區段
# 這裡確保你的 df_results 已經在前面的 cell 中定義好了
if 'df_results' in locals():
    df_results.to_parquet(file_path, index=False)
    print(f"✅ 成功！檔案已儲存至：{file_path}")
    print(f"⏰ 紀錄時間 (台北): {datetime.now(taipei_tz).strftime('%Y-%m-%d %H:%M:%S')}")
else:
    print("❌ 錯誤：找不到 df_results 變數，請確認前面的預測步驟已執行。")

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# MARKDOWN ********************

# ### 將分類結果存到Lakehouse table 裡面

# CELL ********************

import os
import pandas as pd
from datetime import datetime
import pytz
from pyspark.sql.functions import col
import mlflow

# --- 1. 環境與時間設定 ---
taipei_tz = pytz.timezone('Asia/Taipei')
now_taipei = datetime.now(taipei_tz)
timestamp_str = now_taipei.strftime("%Y%m%d_%H%M%S")
current_runtime = now_taipei.strftime('%Y-%m-%d %H:%M:%S')

active_run = mlflow.active_run()
run_id = active_run.info.run_id if active_run else "N/A"

# --- 2. 修正欄位映射 (根據偵測到的原始欄位) ---
if 'df_results' in locals():
    # 這是你提供的真實原始欄位
    # ['Folder_Name', 'Filename', 'Predicted_Label', 'Confidence', 'Is_Correct']
    
    mapping = {
        "Folder_Name": "folder_name",
        "Filename": "file_name",
        "Predicted_Label": "predicted_label",
        "Confidence": "confidence",
        "Is_Correct": "is_correct"
    }

    df_final = df_results.copy()
    
    # 執行重新命名
    df_final = df_final.rename(columns=mapping)

    # 新增追蹤欄位
    df_final["runtime"] = current_runtime
    df_final["mlflow_run_id"] = run_id

    # 定義最終欄位順序
    target_cols = ["folder_name", "file_name", "predicted_label", "confidence", "is_correct", "runtime", "mlflow_run_id"]

    # 確保所有目標欄位都存在 (若不存在則補空值)
    for c in target_cols:
        if c not in df_final.columns:
            df_final[c] = None

    df_final = df_final[target_cols]

    # --- 3. 備份至 Files ---
    file_path = f"/lakehouse/default/Files/Prediction_logs/prediction_{timestamp_str}.parquet"
    os.makedirs(os.path.dirname(file_path), exist_ok=True)
    df_final.to_parquet(file_path, index=False)
    print(f"✅ 檔案備份完成: {file_path}")

    # --- 4. 寫入 Lakehouse Table ---
    try:
        # 強制轉換型別以符合資料庫規範
        spark_df = spark.createDataFrame(df_final) \
            .withColumn("confidence", col("confidence").cast("double")) \
            .withColumn("is_correct", col("is_correct").cast("long")) # 使用 long 提高相容性

        # 處理 Delta 表格衝突：如果表格已存在且型別不合，有時需要覆寫或清除
        # 這裡我們先嘗試正常 append
        spark_df.write \
            .mode("append") \
            .format("delta") \
            .option("mergeSchema", "true") \
            .option("overwriteSchema", "true") \
            .saveAsTable("poker_prediction")
        
        print(f"✅ 數據成功寫入 Table: poker_prediction")
        
    except Exception as e:
        print(f"❌ 寫入表格失敗: {e}")
        print("💡 提示：如果看到型別衝突，建議刪除舊表重新建立：spark.sql('DROP TABLE poker_prediction')")

else:
    print("❌ 找不到 df_results。")

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }
