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

defense = soup.find('section', id='individual-defense')
defense_stat = defense.find('tbody')
fieldnames = ['stat_type', 'stat_number','athleteID','teamID']

with open('FBdefstats.csv', mode="w") as s:
    writer = csv.writer(s, delimiter=',')
    writer.writerow(fieldnames)

    for item in defense_stat.find_all('tr'):
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
            if lastname == "</SPAN":
                lastname = ""
                lname = lastname
                fname = ""
            if fname == "DAMEON":
                lastname = "WILLISJR."
                lname = lastname
                fname = fname
            elif lastname == "BARWICKJR.":
                fname = "MIKE"
                lastname = "BARWICK,JR."
                lname = lastname
            elif fname == "A":
                fname = "ALLEN"
                lname = lastname
            elif lastname == "RIGGINS":
                fname = "ASHON"
                lname = lastname
            elif lastname == "BOWEN":
                fname = "JAMEREZ"
                lname = lastname
            else:
                fname = fname
                lname = lastname
            if fname == "":
                break
            query =('SELECT DISTINCT athleteID FROM athlete WHERE fname ="'+ fname +'" AND lname ="'+lname +'"')
            cursor = db.cursor(buffered=True)
            cursor.execute(query)
            record = cursor.fetchone()
            #print(fname, lname, record[0])
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
                    if stat_type == "TFL-YDS" or stat_type == "Sacks-YDS":
                        dash = stat_type.find('-')
                        numDash = stat_number.find('-')
                        f_type = stat_type[0:dash]
                        f_num = stat_number[0:numDash]
                        entry.append(f_type)
                        entry.append(f_num)
                    #entry.append(fname)
                        entry.append(record[0])
                        entry.append(teamID)
                        writer.writerow(entry)
                        #print(entry)
                        entry = []
# Figure out how to make to entry's for the split entry
                        l_type = stat_type[dash+1:]
                        l_num = stat_number[numDash+1:]
                        entry.append(l_type)
                        entry.append(l_num)
                    else:
                        entry.append(stat_type)
                        entry.append(stat_number)
                    entry.append(record[0])
                    entry.append(teamID)
                    writer.writerow(entry)
                    print(entry)
                    if stat_type == "SAF":
                        entry = []
                    else:
                        entry = []




