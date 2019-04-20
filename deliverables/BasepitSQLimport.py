import csv
import mysql.connector

db = mysql.connector.connect(host = 'db.sice.indiana.edu',
                     user = 'i494f18_team58',
                     passwd = 'my+sql=i494f18_team58',
                     database = 'i494f18_team58')
cursor = db.cursor()

pitStat = csv.reader(file('BasePitstats.csv'), delimiter=',')

next(pitStat)

for row in pitStat:
    cursor.execute('INSERT INTO BSstat(stat_type,stat_number, BSathleteID, teamID) VALUES (%s, %s, %s, %s)',row)
db.commit()
