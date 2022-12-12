#FASTAPI
from typing import Union
from fastapi import FastAPI

#MYSQL
import mysql.connector
from mysql.connector import Error


connection = None
cursor = None

try:
    connection = mysql.connector.connect(host='192.168.12.142',
                                         database='fastapi',
                                         user='fast_user',
                                         password='secret_pass1234')
    if connection.is_connected():
        db_Info = connection.get_server_info()
        print("Connected to MySQL Server version ", db_Info)
        cursor = connection.cursor()
        cursor.execute("select database();")
        record = cursor.fetchone()
        print("You're connected to database: ", record)
        

except Error as e:
    print("Error while connecting to MySQL", e)
                                 
app = FastAPI()


@app.get("/")
def read_root():
    return {"Usage": "/{brand} in order to know the street cred of your car"}


@app.get("/{brand}")
def read_item(brand: str, q: Union[str, None] = None):
	cursor.execute("Select street_cred from brand where title = '{}'".format(brand))
	for x in cursor:
        	print(x)
	return {"cred": x[0]}