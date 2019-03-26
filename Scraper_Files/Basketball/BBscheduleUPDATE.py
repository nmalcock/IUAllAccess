import csv
import mysql.connector

db = mysql.connector.connect(host = 'db.sice.indiana.edu',
                     user = 'i494f18_team58',
                     passwd = 'my+sql=i494f18_team58',
                     database = 'i494f18_team58')
cursor = db.cursor()

#Need to add insert statemnt for future tournament games

with open('BBschedule.csv') as csvfile:
    bbroster = csv.reader(csvfile, delimiter=',')

    next(bbroster)
    for row in bbroster:
        if row != []:
            ##print(row)
            cursor.execute("""UPDATE schedule
                           SET home_score=%s,away_score=%s, w_L=%s, box_score_link=%s
                           WHERE opponent=%s AND date_time=%s AND teamID=1""",(row[3], row[4], row[6], row[7], row[0], row[1]))
db.commit()

