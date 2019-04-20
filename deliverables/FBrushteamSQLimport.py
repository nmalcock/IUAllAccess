import csv
import mysql.connector

db = mysql.connector.connect(host = 'db.sice.indiana.edu',
                     user = 'i494f18_team58',
                     passwd = 'my+sql=i494f18_team58',
                     database = 'i494f18_team58')
cursor = db.cursor()

fbrushteam = csv.reader(file('FBrushTeam.csv'), delimiter=',')

next(fbrushteam)

for row in fbrushteam:
    cursor.execute('INSERT INTO team_stat(stat_type,stat_number, teamID) VALUES (%s, %s, %s)',row)
db.commit()
