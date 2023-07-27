from flask import Flask, jsonify, request
import pandas as pd
import numpy as np
import joblib
import traceback
from flask_restful import reqparse

data = {
   "data":[
      "healthy weight",
      "No",
      "Yes",
      "No",
      "No",
      "Male",
      "40-44",
      "No",
      "No",
      "No",
      "Yes",
      "No",
   ]
}

lr = joblib.load("model-final.pkl")
oe = joblib.load("encoder.pkl")
if lr:
    try:    
        temp=list(data['data'])
        vals=np.array(temp).reshape(1,-1)
        temp = oe.transform(vals)
        prediction = lr.predict_proba(temp)
        print("here:",round(prediction[0][1],2)*100)        
    except:
        print(traceback.format_exc())