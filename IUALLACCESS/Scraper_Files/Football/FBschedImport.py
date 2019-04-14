import csv
import mysql.connector

db = mysql.connector.connect(host = 'db.sice.indiana.edu',
                     user = 'i494f18_team58',
                     passwd = 'my+sql=i494f18_team58',
                     database = 'i494f18_team58')
cursor = db.cursor()

schedule = csv.reader(file('FBschedule.csv'), delimiter=',')
next(schedule)
for row in schedule:
    cursor.execute('INSERT INTO FBschedule(opponent,date_time,site,home_score,away_score,bTenOpp,w_L,box_score_link,teamID) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)',row)
db.commit()
