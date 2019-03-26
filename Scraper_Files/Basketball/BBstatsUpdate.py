import csv
import mysql.connector

db = mysql.connector.connect(host = 'db.sice.indiana.edu',
                     user = 'i494f18_team58',
                     passwd = 'my+sql=i494f18_team58',
                     database = 'i494f18_team58')
cursor = db.cursor()
with open('BBstats.csv') as csvfile:
    bbroster = csv.reader(csvfile, delimiter=',')

    next(bbroster)
    for row in bbroster:
        if row != []:
            print(row)
            cursor.execute("""UPDATE stat
                           SET stat_number=%s
                           WHERE stat_type=%s AND athleteID=%s AND teamID=1""",(row[1], row[0], row[2]))
db.commit()
