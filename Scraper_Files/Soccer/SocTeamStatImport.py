import csv
import mysql.connector

db = mysql.connector.connect(host = 'db.sice.indiana.edu',
                     user = 'i494f18_team58',
                     passwd = 'my+sql=i494f18_team58',
                     database = 'i494f18_team58')
cursor = db.cursor()

Stat = csv.reader(file('SocTeamStat.csv'), delimiter=',')

next(Stat)

for row in Stat:
    cursor.execute('INSERT INTO SCteamStat(stat_type,stat_number, teamID) VALUES (%s, %s, %s)',row)
db.commit()
