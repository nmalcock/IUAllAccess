import csv
import mysql.connector

db = mysql.connector.connect(host = 'db.sice.indiana.edu',
                     user = 'i494f18_team58',
                     passwd = 'my+sql=i494f18_team58',
                     database = 'i494f18_team58')
cursor = db.cursor()

baseroster = csv.reader(file('Baseroster.csv'), delimiter=',')
next(baseroster)
for row in baseroster:
    cursor.execute('INSERT INTO athlete(fname,lname,number,position,year,height,weight,hometown,highschool,image_path,teamID) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)',row)
db.commit()
