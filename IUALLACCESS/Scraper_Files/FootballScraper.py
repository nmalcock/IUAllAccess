import requests
from bs4 import BeautifulSoup
import csv

url = "https://iuhoosiers.com/cumestats.aspx?path=football"
page = requests.get(url, headers={'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.47 Safari/537.36'})

soup = BeautifulSoup(page.content, 'html.parser')

athlete = []
rushing = soup.find('section', id='individual-offense-rushing')

##f = csv.writer(open('stats.csv','w'))
##f.writerow(['fname','lname','stat_type','stat_num'])

for item in rushing.find_all('tr'):
##    name = item.find_all('a')
    number = item.find_all('span')
    stats = item.find_all('td')
    for string in number:
        if len(str(string)) > 45:
            length = len(str(string))
            first = str(string).find("</span> ")
            last = str(string).find(", ")
            num_pos = str(string).find('ber">')
            fname = str(string)[last +len(", "):length-len("</span>")]
            lname = str(string)[first+len("</span> "):last]
            number = str(string)[num_pos + len('ber">'): first]
            print(fname + " " + lname + " " + number)
    for line in stats:
        leng = len(str(line))
##        print(line)
##        print(leng)
        if leng > 45 and leng < 55:
            one_pos = str(line).find('l="')
            two_pos = str(line).find('">')
            three_pos = str(line).find("</td>")
            statType = str(line)[one_pos + len('l="'):two_pos]
            statNum = str(line)[two_pos + len('">'):three_pos]
            print(statType + ": " + statNum)

passing = soup.find('section', id='individual-offense-passing')

receiving = soup.find('section', id='individual-offense-receiving')


