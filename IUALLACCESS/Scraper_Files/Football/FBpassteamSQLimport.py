import csv
import mysql.connector

db = mysql.connector.connect(host = 'db.sice.indiana.edu',
                     user = 'i494f18_team58',
                     passwd = 'my+sql=i494f18_team58',
                     database = 'i494f18_team58')
cursor = db.cursor()

fbpassteam = csv.reader(file('FBpassTeam.csv'), delimiter=',')

next(fbpassteam)

for row in fbpassteam:
    cursor.execute('INSERT INTO FBteamStat(stat_type,stat_number, teamID) VALUES (%s, %s, %s)',row)
db.commit()
