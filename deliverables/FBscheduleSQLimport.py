import csv
import mysql.connector

db = mysql.connector.connect(host = "db.sice.indiana.edu",
                     user = "i494f18_team58",
                     password = "my+sql=i494f18_team58",
                     database = "i494f18_team58")
cursor = db.cursor()

fbschedule = csv.reader(file('FBschedule.csv'), delimiter=',')
next(fbschedule)
for row in fbschedule:
    cursor.execute('INSERT INTO schedule(opponent,date_time,site,home_score,away_score,bTenOpp,w_L,box_score_link,teamID) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)',row)

db.commit()
