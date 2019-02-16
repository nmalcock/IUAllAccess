import requests
from bs4 import BeautifulSoup
import csv

url = "https://iuhoosiers.com/cumestats.aspx?path=mbball&year=2018"
page = requests.get(url, headers={'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.47 Safari/537.36'})

soup = BeautifulSoup(page.content, 'html.parser')

athlete = []
individual = soup.find('section', id='individual-overall')
individual_stat = individual.find('tbody')

f = csv.writer(open('stats.csv','w'))
f.writerow(['fname','lname','statType','statNum'])

for item in individual_stat.find_all('tr'):
    print(item)
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
##            print(fname + " " + lname + " " + number)
##            athlete.append(fname)
##            athlete.append(lname)
##            athlete.append(number)
        for line in stats:
            length = len(str(line))
           # print(length)
            if length > 40 and length < 60:
                one_pos = str(line).find('l="')
                two_pos = str(line).find('">')
                three_pos = str(line).find("</td>")
                statType = str(line)[one_pos + len('l="'):two_pos]
                statNum = str(line)[two_pos + len('">'):three_pos]
    ##            print(statType + ": " + statNum)
    ##            athlete.append(statType + ":" + statNum)
                f.writerow([fname, lname, statType, statNum])
                print(fname + " " + lname + " " + statType + ":" + statNum)
				
