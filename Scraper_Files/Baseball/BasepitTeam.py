import requests
from bs4 import BeautifulSoup
import csv

url = "https://iuhoosiers.com/cumestats.aspx?path=baseball&year=2019"
page = requests.get(url, headers={'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.47 Safari/537.36'})

soup = BeautifulSoup(page.content, 'html.parser')

individual = soup.find('section', id='individual-overall-pitching')
individual_stat = individual.find('tfoot')

entry = []
with open('BasepitTeam.csv', mode="w") as f:
    writer = csv.writer(f)
    writer.writerow(['stat_type','stat_number','teamID'])

    for item in individual_stat.find_all('tr')[:1]:
        stats = item.find_all('td')
            
        for line in stats[1:]:
            length = len(str(line))
            ##print(line)
            ##print(length)
           # print(length)
            if length != 37 or length != 50:
                one_pos = str(line).find('l="')
                two_pos = str(line).find('">')
                three_pos = str(line).find("</td>")
                stat_ty = str(line)[one_pos + len('l="'):two_pos]
                stat_number = str(line)[two_pos + len('">'):three_pos]
##                print(statType + ": " + statNum)
                if stat_ty == "W-L" or stat_ty == "APP-GS":
                    dash = stat_ty.find('-')
                    numDash = stat_number.find('-')
                    f_type = stat_ty[0:dash]
                    f_num = stat_number[0:numDash]
                    entry.append(f_type)
                    entry.append(f_num)
                    entry.append(3)
                    writer.writerow(entry)
                    ##print(entry)
                    entry = []
                    l_type = stat_ty[dash+1:]
                    l_num = stat_number[numDash+1:]
                    entry.append(l_type)
                    entry.append(l_num)
                else:
                    entry.append(stat_ty)
                    entry.append(stat_number)
                entry.append(3)
                ##print(entry)
                writer.writerow(entry)
                if stat_ty == "SHA":
                    entry = []
                    break
                else:
                    entry = []

