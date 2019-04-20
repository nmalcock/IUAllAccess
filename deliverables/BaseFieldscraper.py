import requests
from bs4 import BeautifulSoup
import csv
import mysql.connector

db = mysql.connector.connect(host = 'db.sice.indiana.edu',
                     user = 'i494f18_team58',
                     passwd = 'my+sql=i494f18_team58',
                     database = 'i494f18_team58')

url = "https://iuhoosiers.com/cumestats.aspx?path=baseball&year=2019"
page = requests.get(url, headers={'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.47 Safari/537.36'})

soup = BeautifulSoup(page.content, 'html.parser')

individual = soup.find('section', id='individual-overall-fielding')
individual_stat = individual.find('tbody')

entry = []
with open('BaseFieldstats.csv', mode="w") as f:
    writer = csv.writer(f)
    writer.writerow(['stat_type','stat_number','athleteID','teamID'])

    for item in individual_stat.find_all('tr'):
        stats = item.find_all('td')
        name = item.find('a')
        
        for string in name:
            com = string.find(',')
            last = string[0:com]
            first = string[com+2:]
            fname = first.replace(" ", "")
            lname = last.replace(" ", "")
            query =('SELECT BSathleteID FROM BSathlete WHERE fname ="'+ fname +'" AND lname ="'+lname +'"')
            cursor = db.cursor(buffered=True)
            cursor.execute(query)
            record = cursor.fetchone()
            #print(fname, lname, record[0])
            #record.strip("(,)")
##            entry.append(first)
##            entry.append(last)
        
        for line in stats:
            length = len(str(line))
           # print(length)
            if length > 40 and length < 60:
                one_pos = str(line).find('l="')
                two_pos = str(line).find('">')
                three_pos = str(line).find("</td>")
                stat_ty = str(line)[one_pos + len('l="'):two_pos]
                stat_number = str(line)[two_pos + len('">'):three_pos]
##                print(statType + ": " + statNum)
                if len(stat_ty) < 20:
                    stat_type = stat_ty
                    if stat_type == 'GP-GS' or stat_type == 'SB-ATT':
                        dash = stat_type.find('-')
                        numDash = stat_number.find('-')
                        f_type = stat_type[0:dash]
                        f_num = stat_number[0:numDash]
                        entry.append(f_type)
                        entry.append(f_num)
                        entry.append(record[0])
                        entry.append(3)
                        writer.writerow(entry)
    ##                    print(entry)
                        entry = []
    ## Figure out how to make to entry's for the split entry
                        l_type = stat_type[dash+1:]
                        l_num = stat_number[numDash+1:]
                        entry.append(l_type)
                        entry.append(l_num)
                    else:
                        entry.append(stat_type)
                        entry.append(stat_number)
                    entry.append(record[0])
                    entry.append(3)
                    writer.writerow(entry)
                    print(entry)
                    if stat_type == "CI":
                        entry = []
                    else:
                        entry = []



