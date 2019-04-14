import csv
import mysql.connecter

db = MySQLdb.connect(host = 'db.sice.indiana.edu',
                     username = 'i494f18_team58',
                     password = 'my+sql=i494f18_team58',
                     database = 'i494f18_team58')
cursor = db.cursor()

csv_stats = csv.reader(file('stats.csv'))

athlete = "SELECT userID, fname, lname FROM athlete"
print(athlete)
##for row in csv_stats:
##    
##    
##    cursor.execute('INSERT INTO stats(
