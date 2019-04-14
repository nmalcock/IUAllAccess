import csv
import mysql.connector

db = mysql.connector.connect(host = 'db.sice.indiana.edu',
                     user = 'i494f18_team58',
                     passwd = 'my+sql=i494f18_team58',
                     database = 'i494f18_team58')
cursor = db.cursor()

basebatteam = csv.reader(file('BasebatTeam.csv'), delimiter=',')

next(basebatteam)

for row in basebatteam:
    cursor.execute('INSERT INTO BSteamStat(stat_type,stat_number, teamID) VALUES (%s, %s, %s)',row)
db.commit()
