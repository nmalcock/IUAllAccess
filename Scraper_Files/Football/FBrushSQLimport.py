import csv
import mysql.connector

db = mysql.connector.connect(host = 'db.sice.indiana.edu',
                     user = 'i494f18_team58',
                     passwd = 'my+sql=i494f18_team58',
                     database = 'i494f18_team58')
cursor = db.cursor()

fbrushStat = csv.reader(file('FBrushStats.csv'), delimiter=',')

next(fbrushStat)

for row in fbrushStat:
    cursor.execute('INSERT INTO FBstat(stat_type,stat_number, FBathleteID, teamID) VALUES (%s, %s, %s, %s)',row)
db.commit()
