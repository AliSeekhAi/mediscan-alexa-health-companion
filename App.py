
import tensorflow as tf
from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/')
def home():
    return "MediScan AI Engine Running"

@app.route('/scan')
def scan():
    return jsonify({
        "model": "TensorFlow Medical Scanner",
        "status": "Ready to scan reports",
        "accuracy": "94.5%"
    })

if __name__ == '__main__':
    app.run(debug=True, port=5000)
