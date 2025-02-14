from flask import Flask
from urllib.parse import quote as url_quote

app = Flask(__name__)

@app.route('/')
def home():
    return "Flask App is Running!"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
