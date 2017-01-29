import os
import json
import schedule
import time
import thread
from flask import Flask, request, abort
from flask_mail import Mail, Message

app = Flask(__name__)

# Webhook, Scheduled
app.config["MODE"] = os.environ["MODE"]

# For webhook security
app.config["TOKEN"] = os.environ["TOKEN"]

# Mail configurations
app.config["MAIL_TITLE"] = os.environ["MAIL_TITLE"]
app.config["MAIL_SERVER"] = os.environ["MAIL_SERVER"]
app.config["MAIL_PORT"] = int(os.environ["MAIL_PORT"])
app.config["MAIL_USE_SSL"] = bool(os.environ["MAIL_USE_SSL"])
app.config["MAIL_USERNAME"] = os.environ["MAIL_USERNAME"]
app.config["MAIL_PASSWORD"] = os.environ["MAIL_PASSWORD"]

mail = Mail(app)

sender = os.environ["MAIL_SENDER"]
recipient = os.environ["MAIL_RECIPIENT"]

status='WAITING'

@app.route('/api/trigger', methods=['POST'])
def webhookTrigger():
    return "OK"

@app.route('/api/status', methods=['GET'])
def getStatus():
    return status

def schedule():
    schedule.every().wednesday.at("00:15").do(task)
    while True:
        schedule.run_pending()
        time.sleep(1)

def task():
    print("Doing the task")

def sendEmail(title, body):
    msg = Message(title,
                  sender=sender,
                  recipients=[recipient])
    msg.body = body 
    mail.send(msg)

@app.route("/")
def index():
    return "This is a service, and you are using it wrong !"

if __name__ == "__main__":
    thread.start_new_thread (schedule)
    app.run(host='0.0.0.0', port=8080,threaded=True)
