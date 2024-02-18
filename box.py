import RPi.GPIO as GPIO             
from time import sleep
from mfrc522 import SimpleMFRC522
import pyrebase
import os
import pygame
import random

config = {     
  "apiKey": "AIzaSyBXTBAa0x7uCKCCzYxZZ0825LDMODFVfwk",
  "authDomain": "makeuoft-2024.firebaseapp.com",
  "databaseURL": "https://makeuoft-2024-default-rtdb.firebaseio.com",
  "storageBucket": "makeuoft-2024.appspot.com"
}

firebase = pyrebase.initialize_app(config)

GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)

reader = SimpleMFRC522()

servo = 18

GPIO.setup(servo,GPIO.OUT)

servo_pwm = GPIO.PWM(servo, 50)

servo_pwm.start(0)

def set_servo_angle(angle):
    duty_cycle = (angle / 18.0) + 2.5
    servo_pwm.ChangeDutyCycle(duty_cycle)
    sleep(2)
    servo_pwm.ChangeDutyCycle(0)


def open_box():
    set_servo_angle(10)

def close_box():
    set_servo_angle(185)
    
counter = 0
id = 0
    
try:
	print("Place Tag")
	while True:
		
		db = firebase.database()
		isClosed = db.child("isClosed").get().val()
		
		if (id == 352776167287):
			close_box()
			print("Closed Box")
			sleep(1)
		if (id == 681898333127):
			open_box()
			print("Opened Box")
			id = 0
			sleep(1)
		if isClosed != 2:
			if isClosed == 0:
				open_box()
				print("Opened Box via DB")
				db.update({"isClosed":2})
			if isClosed == 1:
				open_box()
				print("Closed Box via DB")
				db.update({"isClosed":2})
		sleep(1)
		id,text = reader.read()
		print(id)
		print(text)
		
        

except KeyboardInterrupt: 		
    pass
    
finally:
    servo_pwm.stop()
    GPIO.cleanup()
