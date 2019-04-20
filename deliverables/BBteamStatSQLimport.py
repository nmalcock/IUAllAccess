import csv
import mysql.connector

db = mysql.connector.connect(host = 'db.sice.indiana.edu',
                     user = 'i494f18_team58',
                     passwd = 'my+sql=i494f18_team58',
                     database = 'i494f18_team58')
cursor = db.cursor()

bbroster = csv.reader(file('BBstatTeam.csv'), delimiter=',')

next(bbroster)

for row in bbroster:
    cursor.execute('INSERT INTO BBteamStat(stat_type,stat_number, teamID) VALUES (%s, %s, %s)',row)
db.commit()
