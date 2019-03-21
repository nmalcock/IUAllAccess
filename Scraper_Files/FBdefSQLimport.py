import csv
import mysql.connector

db = mysql.connector.connect(host = 'db.sice.indiana.edu',
                     user = 'i494f18_team58',
                     passwd = 'my+sql=i494f18_team58',
                     database = 'i494f18_team58')
cursor = db.cursor()

fbdefStat = csv.reader(file('FBdefstats.csv'), delimiter=',')

next(fbdefStat)

for row in fbdefStat:
    cursor.execute('INSERT INTO stat(stat_type,stat_number, athleteID, teamID) VALUES (%s, %s, %s, %s)',row)
db.commit()
