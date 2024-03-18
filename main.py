# from typing import Union
from fastapi import FastAPI
import firebase_admin
from firebase_admin import db
from firebase_admin import storage
from transformers import pipeline


# from pydantic import BaseModel
import json
databaseURL = "https://divyanga-default-rtdb.firebaseio.com"
bucketName = "divyanga.appspot.com"


app = FastAPI()

cred_obj = firebase_admin.credentials.Certificate('divyanga-firebase.json')
default_app = firebase_admin.initialize_app(cred_obj, {
    'databaseURL':databaseURL,
    'storageBucket':bucketName})


bucket_ref = storage.bucket()
db_ref = db.reference('/')

unmasker = pipeline('fill-mask', model='distilbert-base-uncased')
pipe = pipeline("text-classification", model="textattack/distilbert-base-uncased-CoLA", from_pt=True)

class User():
    def __init__(self, age, std, ndd, loginid, email, pw) -> None:
        self.age = age
        self.standard = std
        self.ndd = ndd
        self.loginid = loginid
        self.email = email
        self.password = pw
    age : str
    standard : str
    ndd : str
    loginid : str
    email : str
    password : str



@app.get("/")
def read_root():
    try:
        data = db_ref.get()
        return data
    except:
        return {
            'msg' : 'error'
        }
    finally:
        print("GET / called")


@app.put("/test")
def set_data(objdata : dict):
    try:
        # db_ref.child('obj2').set(
        #     json.dumps(objdata)[2:-2]
        # )
        # return json.dumps(objdata, separators=[",", ":"])
        return pipe("This is a leopard")
    except:
        print("an error occured")
    finally:
        print("PUT /test called") 

@app.get("/testroute")
def push_data():
    try:
        db_ref.child('user').set({
            'loginid' : 2,
            'username' : 'testuser'
        })
        return {
            'msg' : 'success'
        }
    except:
        return {
            'msg' : 'error'
        }
    finally:
        print("GET /testroute called")

@app.get("/test/mlm-model")
def get_res():
    try:
        sentence = "The is one of the most ferocious animals."
        temp = sentence.split()
        bestanswers = []
        # return unmasker("The [MASK] is one of the most ferocious animals.")
        for pos in range(len(temp) - 1):
            ans = []
            res = temp[:pos] + ["[MASK]"] + temp[pos:]
            res = ' '.join(res)
            results = unmasker(str(res))
            for result in results:
                ans.append(result)
            maxscore = 0
            for a in ans:
                if a['score'] > maxscore:
                    bestanswers.append(a)
                    maxscore = a['score']
        # maxscore = 0
        # for bestans in bestanswers:
        #     if pipe(bestans['sequence'])['label1']
        return bestanswers
    except:
        return {
            'msg' : 'error'
        }
    
