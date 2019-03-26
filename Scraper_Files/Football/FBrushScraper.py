import requests
from bs4 import BeautifulSoup
import csv
import mysql.connector

db = mysql.connector.connect(host = 'db.sice.indiana.edu',
                     user = 'i494f18_team58',
                     passwd = 'my+sql=i494f18_team58',
                     database = 'i494f18_team58')

url = "https://iuhoosiers.com/cumestats.aspx?path=football"
page = requests.get(url, headers={'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.47 Safari/537.36'})

soup = BeautifulSoup(page.content, 'html.parser')

entry = []
teamID = 2
rushing = soup.find('section', id='individual-offense-rushing')
rushing_stat = rushing.find('tbody')
#team data causing problems
fieldnames = ['stat_type', 'stat_number','athleteID','teamID']
with open('FBrushStats.csv', mode="w") as s:
    writer = csv.writer(s, delimiter=',')
    writer.writerow(fieldnames)

    for item in rushing_stat.find_all('tr'):
        stats = item.find_all('td')
        name = item.find_all('span')
        for string in name:
            if len(str(string)) > 45:
                length = len(str(string))
                first = str(string).find("</span> ")
                last = str(string).find(", ")
                faname = str(string)[last +len(", "):length-len("</span>")]
                laname = str(string)[first+len("</span> "):last]
            firstname = faname.replace(" ", "")
            lastname = laname.replace(" ", "")
            if len(firstname) < 40:
                fname = firstname
            fname = fname.upper()
            lastname = lastname.upper()
            if lastname != "TEAM</SPAN":
                lname = lastname
            #print(fname, len(fname), lname, len(lname))
            if fname == "RONNIE":
                lname = "WALKERJR."
            elif fname == "MICHAEL":
                lname = "PENIXJR."
            query =('SELECT DISTINCT FBathleteID FROM FBathlete WHERE fname ="'+ fname +'" AND lname ="'+lname +'"')
            cursor = db.cursor(buffered=True)
            cursor.execute(query)
            record = cursor.fetchone()
            #print(fname, lname)
        for line in stats:
            leng = len(str(line))
    ##        print(line)
    ##        print(leng)
            if leng > 45 and leng < 55:
                one_pos = str(line).find('l="')
                two_pos = str(line).find('">')
                three_pos = str(line).find("</td>")
                statType = str(line)[one_pos + len('l="'):two_pos]
                if len(statType) < 10:
                    stat_type = statType
                    stat_num = str(line)[two_pos + len('">'):three_pos]
                    stat_number = stat_num.replace("-", "")
                    #entry.append(fname)
                    entry.append(stat_type)
                    entry.append(stat_number)
                    entry.append(record[0])
                    entry.append(teamID)
                    writer.writerow(entry)
                    print(entry)
                    if stat_type == "AVG/G":
                        entry = []
                    else:
                        entry = []

