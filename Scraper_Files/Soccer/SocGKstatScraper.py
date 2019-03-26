import requests
from bs4 import BeautifulSoup
import csv
import mysql.connector

db = mysql.connector.connect(host = 'db.sice.indiana.edu',
                     user = 'i494f18_team58',
                     passwd = 'my+sql=i494f18_team58',
                     database = 'i494f18_team58')

url = "https://iuhoosiers.com/cumestats.aspx?path=msoc&year=2018#individual"
page = requests.get(url, headers={'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.47 Safari/537.36'})

soup = BeautifulSoup(page.content, 'html.parser')


individual_gk = soup.find('section', id="individual-overall-goalkeeping")
individual_stat_gk = individual_gk.find('tbody')

entry = []
with open('SocGkStats.csv', mode="w") as f:
    writer = csv.writer(f)
    writer.writerow(['stat_type','stat_number','SCathleteID','teamID'])

    
    for item in individual_stat_gk.find_all('tr'):
        stats = item.find_all('td')
        name = item.find('a')
        
        for string in name:
            com = string.find(',')
            last = string[0:com]
            first = string[com+2:]
            query =('SELECT SCathleteID FROM SCathlete WHERE fname ="'+ first +'" AND lname ="'+last +'"')
            cursor = db.cursor(buffered=True)
            cursor.execute(query)
            record = cursor.fetchone()
            ##record.strip("(,)")
            ##entry.append(first)
            ##entry.append(last)
        
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
                if stat_type == 'GP-GS':
                    dash = stat_type.find('-')
                    numDash = stat_number.find('-')
                    f_type = stat_type[0:dash]
                    f_num = stat_number[0:numDash]
                    entry.append(f_type)
                    entry.append(f_num)
                    entry.append(record[0])
                    entry.append(4)
                    writer.writerow(entry)
                    #print(entry)
                    entry = []
                    l_type = stat_type[dash+1:]
                    l_num = stat_number[numDash+1:]
                    entry.append(l_type)
                    entry.append(l_num)
                elif stat_type == 'SHO/CBO':
                    dash = stat_type.find('/')
                    numDash = stat_number.find('/')
                    f_type = stat_type[0:dash]
                    f_num = stat_number[0:numDash]
                    entry.append(f_type)
                    entry.append(f_num)
                    entry.append(record[0])
                    entry.append(4)
                    writer.writerow(entry)
                    #print(entry)
                    entry = []
                    l_type = stat_type[dash+1:]
                    l_num = stat_number[numDash+1:]
                    entry.append(l_type)
                    entry.append(l_num)
                elif stat_type == 'MIN':
                    numDash = stat_number.find(':')
                    f_num = stat_number[0:numDash]
                    entry.append(stat_type)
                    entry.append(f_num)
                else:
                    entry.append(stat_type)
                    entry.append(stat_number)
                entry.append(record[0])
                entry.append(4)
                writer.writerow(entry)
                print(entry)
                if stat_type == "SF":
                    entry = []
                else:
                    entry = []
