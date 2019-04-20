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
passing = soup.find('section', id='individual-offense-passing')
receiving = soup.find('section', id='individual-offense-receiving')
defense = soup.find('section', id='individual-defense')

fieldnames = ['stat_type', 'stat_number','athleteID','teamID']
with open('FBstats.csv', mode="w") as s:
    writer = csv.writer(s, delimiter=',')
    writer.writerow(fieldnames)

    for item in rushing.find_all('tr'):
        stats = item.find_all('td')
        name = item.find_all('span')
        for string in name:
            if len(str(string)) > 45:
                length = len(str(string))
                first = str(string).find("</span> ")
                last = str(string).find(", ")
##                num_pos = str(string).find('ber">')
                fname = str(string)[last +len(", "):length-len("</span>")]
                lname = str(string)[first+len("</span> "):last]
##                number = str(string)[num_pos + len('ber">'): first]
            fname = fname.replace(" ", "")
            lname = lname.replace(" ", "")
            query =('SELECT athleteID FROM athlete WHERE fname ="'+ fname +'" AND lname ="'+lname +'"')
            cursor = db.cursor(buffered=True)
            cursor.execute(query)
            record = cursor.fetchone()
##                if len(fname) < 30:
####                    print(fname, ":", len(fname))
####                    print(lname, ":", len(lname))
####                    entry.append(fname)
####                    entry.append(lname)
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
                    if record is not None:
            ##                print(record)
                        entry.append(stat_type)
                        entry.append(stat_number)
                        entry.append(teamID)
                        entry.append(record[0])
                    if stat_type == "AVG/G":
                        entry = []
                    else:
                        entry = []

    for item in passing.find_all('tr'):
        stats = item.find_all('td')
        name = item.find_all('span')
        
        for string in name:
            if len(str(string)) > 45:
##                print(string)
                length = len(str(string))
                first = str(string).find("</span> ")
                last = str(string).find(", ")
##                num_pos = str(string).find('ber">')
                fname = str(string)[last +len(", "):length-len("</span>")]
                lname = str(string)[first+len("</span> "):last]
##                number = str(string)[num_pos + len('ber">'): first]
                #print(fname, lname)

            fname = fname.replace(" ", "")
            lname = lname.replace(" ", "")
            query =('SELECT athleteID FROM athlete WHERE fname ="'+ fname +'" AND lname ="'+lname +'"')
            cursor = db.cursor(buffered=True)
            cursor.execute(query)
            record = cursor.fetchone()
##            print(record)
##            print(record)
##                print(fname, lname, record)
##            if len(fname) < 30:
##                    print(fname, ":", len(fname))
##                    print(lname, ":", len(lname))
##                    entry.append(fname)
##                    entry.append(lname)
##                print(fname, lname)
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
                    #entry.append(stat_type)
                    stat_num = str(line)[two_pos + len('">'):three_pos]
                    stat_number = stat_num.replace("-", "")
                    #entry.append(stat_number)
                    if record is not None:
                ##                print(record)
                        entry.append(stat_type)
                        entry.append(stat_number)
                        entry.append(teamID)
                        entry.append(record[0])
                        #print(entry) 
                    if stat_type == "AVG/G":
                        entry = []
                    else:
                        entry = []



    for item in receiving.find_all('tr'):
        stats = item.find_all('td')
        name = item.find_all('span')
        for string in name:
            if len(str(string)) > 45:
                length = len(str(string))
                first = str(string).find("</span> ")
                last = str(string).find(", ")
##                num_pos = str(string).find('ber">')
                fname = str(string)[last +len(", "):length-len("</span>")]
                lname = str(string)[first+len("</span> "):last]
##                number = str(string)[num_pos + len('ber">'): first]
##                if len(fname) < 30:
##                    print(fname, ":", len(fname))
##                    print(lname, ":", len(lname))
##                    entry.append(fname)
##                    entry.append(lname)
            fname = fname.replace(" ", "")
            lname = lname.replace(" ", "")
            query =('SELECT athleteID FROM athlete WHERE fname ="'+ fname +'" AND lname ="'+lname +'"')
            cursor = db.cursor(buffered=True)
            cursor.execute(query)
            record = cursor.fetchone()
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
                #entry.append(stat_type)
                    stat_num = str(line)[two_pos + len('">'):three_pos]
                    stat_number = stat_num.replace("-", "")
                #entry.append(stat_number)
                    if record is not None:
            ##                print(record)
                        entry.append(stat_type)
                        entry.append(stat_number)
                        entry.append(teamID)
                        entry.append(record[0])
                    #print(entry)
                    if stat_type == "AVG/G":
                        entry = []
                    else:
                        entry = []
##                    
    for item in defense.find_all('tr'):
        stats = item.find_all('td')
        name = item.find_all('span')
        for string in name:
            if len(str(string)) > 45:
                length = len(str(string))
                first = str(string).find("</span> ")
                last = str(string).find(", ")
                num_pos = str(string).find('ber">')
                fname = str(string)[last +len(", "):length-len("</span>")]
                lname = str(string)[first+len("</span> "):last]
                number = str(string)[num_pos + len('ber">'): first]
##                if len(fname) < 30:
##                    print(fname, ":", len(fname))
##                    print(lname, ":", len(lname))
##                    entry.append(fname)
##                    entry.append(lname)
            fname = fname.replace(" ", "")
            lname = lname.replace(" ", "")
            query =('SELECT athleteID FROM athlete WHERE fname ="'+ fname +'" AND lname ="'+lname +'"')
            cursor = db.cursor(buffered=True)
            cursor.execute(query)
            record = cursor.fetchone()
        for line in stats:
            leng = len(str(line))
##                        print(line)
##                        print(leng)
            if leng > 45 and leng < 70:
                one_pos = str(line).find('l="')
                two_pos = str(line).find('">')
                three_pos = str(line).find("</td>")
                statType = str(line)[one_pos + len('l="'):two_pos]
                #print(statType)
                if len(statType) > 11 and len(statType) < 30:
                    FL = statType.find('"')
                    stat = statType[0:FL]
                    stat_type = stat
##                    entry.append(stat_type)
                    stat_number = str(line)[two_pos + len('">'):three_pos]
##                    entry.append(stat_number)
                if len(statType) < 10:
                    stat_type = statType
##                    entry.append(stat_type)
                    stat_num = str(line)[two_pos + len('">'):three_pos]
                    stat_number = stat_num.replace("-", "")
##                    entry.append(stat_number)
##                              print(stat_type, ":", len(stat_type), " ", stat_number, len(stat_number))
##                              print(fname, " ", stat_type, ":", stat_number)

                    if record is not None:
                    ##                print(record)
                        entry.append(stat_type)
                        entry.append(stat_number)
                        entry.append(teamID)
                        entry.append(record[0])
                            #print(entry) 
                    if stat_type == "SAF":
                        entry = []
                    else:
                        entry = []

print(entry)
