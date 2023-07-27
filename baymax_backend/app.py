from flask import Flask, jsonify, request
import pandas as pd
import numpy as np
import joblib
from flask_restful import reqparse
import os
import tensorflow as tf

from pre import loadm
app = Flask(__name__)
# path = os.getcwd()
interpreter = tf.lite.Interpreter(model_path="ecg_model.tflite")
interpreter.allocate_tensors()

input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()



@app.route("/", methods=['GET'])
def hello():
    return "hey"


@app.route('/predict', methods=['POST'])
def predict():
 lr = joblib.load("model-final.pkl")
 oe = joblib.load("encoder.pkl")
 if lr:
  
        json = request.get_json()  
       
        temp=list(json['data'])
        vals=np.array(temp).reshape(1,-1)
        temp = oe.transform(vals)
        prediction = lr.predict_proba(temp)
        print("here:",prediction)        
        return jsonify({'prediction': str(round(prediction[0][1],2)*100)})
    
 else:
    return ('No model here to use')
 
@app.route('/predict-ecg', methods=['POST'])
def predict_ecg():
    lr = joblib.load("model-final.pkl")
    if lr:
    
            f = request.files['file']
            f.save(("data.mat"))
            ecg = loadm("data.mat")
            interpreter.set_tensor(input_details[0]['index'], ecg)
            interpreter.invoke()

            prediction = interpreter.get_tensor(output_details[0]['index'])
            y = prediction[0]
            y[ y < 0.5 ] =int(0)
            y[ y >= 0.5 ] =int(1)
            # prediction = 0
            
            # print("here:",len(prediction))
            
            return jsonify({'prediction': str(y.tolist())})
        
    else:
        return ('No model here to use')
 
if __name__ == '__main__':
    app.run(debug=True)

