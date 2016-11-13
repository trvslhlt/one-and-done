from flask import Flask
from werkzeug.contrib.fixers import ProxyFix

app = Flask(__name__)
app.wsgi_app = ProxyFix(app.wsgi_app)

@app.route("/")
def hello():
    return "Hello world!"


if __name__ == "__main__":
    app.run()
