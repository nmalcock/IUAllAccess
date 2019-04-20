import requests
from bs4 import BeautifulSoup
import csv

url = "https://iuhoosiers.com/cumestats.aspx?path=baseball&year=2019"
page = requests.get(url, headers={'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.47 Safari/537.36'})

soup = BeautifulSoup(page.content, 'html.parser')

individual = soup.find('section', id='individual-overall-batting')
#print(individual)
individual_stat = individual.find('tfoot')

entry = []
with open('BasebatTeam.csv', mode="w") as f:
    writer = csv.writer(f)
    writer.writerow(['stat_type','stat_number','teamID'])

    for item in individual_stat.find_all('tr')[:1]:
        stats = item.find_all('td')
            
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
                if len(stat_ty) < 15:
                    stat_type = stat_ty
##                if len(stat_num) > 0:
##                    stat_number = stat_num
                entry.append(stat_type)
                entry.append(stat_number)
                entry.append(3)
                print(entry)
                #insert into database before writing into csv, insert ignore 
                writer.writerow(entry)
                
                if stat_type == "SB":
                    entry = []
                else:
                    entry = []




