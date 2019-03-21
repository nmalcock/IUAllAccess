import csv
import mysql.connector

db = mysql.connector.connect(host = 'db.sice.indiana.edu',
                     user = 'i494f18_team58',
                     passwd = 'my+sql=i494f18_team58',
                     database = 'i494f18_team58')
cursor = db.cursor()

fbroster = csv.reader(file('FBroster.csv'), delimiter=',')
next(fbroster)
for row in fbroster:
    cursor.execute('INSERT INTO athlete(fname,lname,number,position,year,height,weight,hometown,highschool,image_path,teamID) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)',row)
db.commit()
