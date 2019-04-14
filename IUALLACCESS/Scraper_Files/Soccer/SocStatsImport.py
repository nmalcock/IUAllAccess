import csv
import mysql.connector

db = mysql.connector.connect(host = 'db.sice.indiana.edu',
                     user = 'i494f18_team58',
                     passwd = 'my+sql=i494f18_team58',
                     database = 'i494f18_team58')
cursor = db.cursor()

stats = csv.reader(file('SocStats.csv'), delimiter=',')

next(stats)

for row in stats:
    cursor.execute('INSERT INTO SCstat(stat_type,stat_number, SCathleteID, teamID) VALUES (%s, %s, %s, %s)',row)
db.commit()
