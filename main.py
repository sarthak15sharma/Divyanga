# from typing import Union
import shutil
from fastapi import FastAPI, Request, Depends, UploadFile, File
import io
import base64
from PIL import Image
import numpy as np
# from transformers import pipeline, TFGPT2Tokenizer, TFGPT2Model, GPT2Config, AutoTokenizer
import json
import tensorflow as tf
from pydantic import BaseModel
from utilfunctions import get_img_label, predict_reversal, convert_pdf_to_text, spell_check



# databaseURL = "https://divyanga-default-rtdb.firebaseio.com"
# bucketName = "divyanga.appspot.com"


app = FastAPI()

# cred_obj = firebase_admin.credentials.Certificate('divyanga-firebase.json')
# default_app = firebase_admin.initialize_app(cred_obj, {
#     'databaseURL':databaseURL,
#     'storageBucket':bucketName})


# bucket_ref = storage.bucket()
# db_ref = db.reference('/')

# unmasker = pipeline('fill-mask', model='distilbert-base-uncased')
# # pipe = pipeline("text-classification", model="textattack/distilbert-base-uncased-CoLA", from_pt=True)
async def parse_body(request : Request):
    data : bytearray = await request.body()
    return data


class Item(BaseModel):
    image: str

class Strinput(BaseModel):
    inputs: str


@app.post("/getImgLabel")
async def get_imglabel():
    res = get_img_label()
    return {
        'result' : res
    }


@app.post('/upload')
def upload_file(uploaded_file: UploadFile = File(...)):
    path = f"files/{uploaded_file.filename}"
    output_dir = "files/output/"
    with open(path, 'w+b') as file:
        shutil.copyfileobj(uploaded_file.file, file)

    convert_pdf_to_text(pdf_path=path, ocr_folder=output_dir)
    return {
        'file': uploaded_file.filename,
        'content': uploaded_file.content_type,
        'path': path,
    }


@app.post("/spellcheck")
async def get_features(s1 : Strinput):
    res = spell_check(s1.inputs)
    return {
        'result' : res
    }

@app.post("/showinputdata")
async def parse_input(data : bytes = Depends(parse_body)):
    try:
        print(data)
        print(type(data))
    except Exception as e:
        print("error", e)
    finally:
        print("request received")


# @app.get("/testroute")
# def push_data():
#     try:
#         db_ref.child('user').set({
#             'loginid' : 2,
#             'username' : 'testuser'
#         })
#         return {
#             'msg' : 'success'
#         }
#     except Exception as e:
#         return {
#             'msg' : 'an error occurred',
#             'error' : e
#         }
#     finally:
#         print("GET /testroute called")


# @app.put("/get-correct-sentence")
# def get_res():
#     try:
#         sentence = "The is one of the most ferocious animals."
#         temp = sentence.split()
#         bestanswers = []
#         # return unmasker("The [MASK] is one of the most ferocious animals.")
#         for pos in range(len(temp) - 1):
#             ans = []
#             res = temp[:pos] + ["[MASK]"] + temp[pos:]
#             res = ' '.join(res)
#             results = unmasker(str(res))
#             for result in results:
#                 ans.append(result)
#             maxscore = 0
#             for a in ans:
#                 if a['score'] > maxscore:
#                     bestanswers.append(a['sequence'])
#                     maxscore = a['score']
#         for b in bestanswers:
#             inputs = tokenizer(b, return_tensors="tf", padding=True, truncation=True)
#             output = model(inputs)
#             predicted = tf.argmax(output.logits, axis=1).numpy()
#             if predicted.item() == 1:
#                 return {b}
#             else:
#                 print("logged")
#         return {
#             'msg' : 'no correct sentence found'
#         }
#         # return bestanswers
#     except Exception as e:
#         return e
    
@app.post("/reversal")
async def upload_image(item: Item):
    # Read the JSON body of the request
    # data = await request.json()
    
    # Extract the base64 image data
    base64_image = item.image
    
    # Decode base64 image string
    image_bytes = base64.b64decode(base64_image)
    
    # Create PIL Image object from bytes
    img = Image.open(io.BytesIO(image_bytes))
    rgb_image = img.convert('RGB')
    
    # Save the image as JPEG
    img_path = "uploaded_image.jpg"
    rgb_image.save(img_path, format='JPEG')
    res = predict_reversal(image_path=img_path)
    return {
        'result' : res
    }
