import requests
from bs4 import BeautifulSoup
import csv

url = "https://iuhoosiers.com/cumestats.aspx?path=msoc&year=2018"
page = requests.get(url, headers={'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.47 Safari/537.36'})

soup = BeautifulSoup(page.content, 'html.parser')

individual = soup.find('section', id="individual-overall-goalkeeping")
individual_stat = individual.find('tfoot')

entry = []
with open('SocTeamGkStat.csv', mode="w") as f:
    writer = csv.writer(f)
    writer.writerow(['stat_type','stat_number','teamID'])

    for item in individual_stat.find_all('tr')[:1]:
        stats = item.find_all('td')
            
        for line in stats:
            length = len(str(line))
           ## print(length)
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
                entry.append(4)
                writer.writerow(entry)
 ##               print(entry)
                if stat_type == "SF":
                    entry = []
                    break
                else:
                    entry = []
