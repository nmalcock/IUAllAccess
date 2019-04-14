import requests
from bs4 import BeautifulSoup
import csv
import mysql.connector

db = mysql.connector.connect(host = 'db.sice.indiana.edu',
                     user = 'i494f18_team58',
                     passwd = 'my+sql=i494f18_team58',
                     database = 'i494f18_team58')

url = "https://iuhoosiers.com/cumestats.aspx?path=mbball&year=2018"
page = requests.get(url, headers={'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.47 Safari/537.36'})

soup = BeautifulSoup(page.content, 'html.parser')

individual = soup.find('section', id='individual-overall')
individual_stat = individual.find('tbody')

entry = []
with open('BBstats.csv', mode="w") as f:
    writer = csv.writer(f)
    writer.writerow(['stat_type','stat_number','athleteID','teamID'])

    for item in individual_stat.find_all('tr'):
        stats = item.find_all('td')
        name = item.find_all('span')
        
        for string in name:
            if len(str(string)) > 45:
                length = len(str(string))
                first = str(string).find("</span> ")
                last = str(string).find(", ")
##                num_pos = str(string).find('ber">')
                firstname = str(string)[last +len(", "):length-len("</span>")]
                lastname = str(string)[first+len("</span> "):last]
##                number = str(string)[num_pos + len('ber">'): first]
##                print(fname + " " + lname)
                #entry.append(firstname)
                #entry.append(lastname)
                
            #query =('SELECT athleteID FROM athlete WHERE fname =' AND 'lname = ';')
            first = firstname
            last = lastname
            query =('SELECT athleteID FROM athlete WHERE fname ="'+ first +'" AND lname ="'+last +'"')
            cursor = db.cursor(buffered=True)
            cursor.execute(query)
            record = cursor.fetchone()
            #record.strip("(,)")
            #entry.append(record)
        
        for line in stats:
            length = len(str(line))
           # print(length)
            if length > 40 and length < 60:
                one_pos = str(line).find('l="')
                two_pos = str(line).find('">')
                three_pos = str(line).find("</td>")
                stat_type = str(line)[one_pos + len('l="'):two_pos]
                stat_number = str(line)[two_pos + len('">'):three_pos]
##                print(statType + ": " + statNum)

                entry.append(stat_type)
                entry.append(stat_number)
                entry.append(record[0])
                entry.append(1)
                writer.writerow(entry)
                if stat_type == "BLK":
                    entry = []
                else:
                    entry = []








        

            


