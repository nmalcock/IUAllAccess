import requests
from bs4 import BeautifulSoup
import csv

url = "https://iuhoosiers.com/cumestats.aspx?path=football"
page = requests.get(url, headers={'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.47 Safari/537.36'})

soup = BeautifulSoup(page.content, 'html.parser')

individual = soup.find('section', id='individual-offense-rushing')
#need to find a way to omit team stats
#prints additional code with name and number of player
#individual_stat = individual.find('title=Ha')

f = csv.writer(open('fbstats.csv','w'))
f.writerow(['fname','lname','statType','statNum'])

for item in individual.find_all('tr'):
    #print(item)
    stats = item.find_all('td')
    #stats = stat.find_all('</span></th>')
    #only diff between team data and individual is </span></th> as consecutive tags
    name = item.find_all('span')
    for string in name:
        #print(string)
        if len(str(string)) > 45:
            #print(string)
            length = len(str(string))
            first = str(string).find("</span> ")
            #print(first)
            last = str(string).find(", ")
            #print(last)
            num_pos = str(string).find('ber">')
            #removes unwanted line of code from first name and fixes name and number
            if last > 0:
                fname = str(string)[last +len(", "):length-len("</span>")]
                #print(fname)
                lname = str(string)[first+len("</span> "):last]
                print(lname)
                #lname prints </span> tag with unwanted line team
                number = str(string)[num_pos +len('ber">'): first]
                #print(number)
                #number prints in the correct way
                #print(fname + " " + lname + " " + number)
            for line in stats:
                #print(line)
                length = len(str(line))
                #print(length, line)
                if length > 40 and length < 60:
                    one_pos = str(line).find('l="')
                    #print(one_pos)#(-1 is potentially problem)
                    two_pos = str(line).find('">')
                    #print(two_pos)
                    three_pos = str(line).find("</td>")
                    #print(three_pos)
                    if one_pos > 0: 
                        statType = str(line)[one_pos + len('l="'):two_pos]
                        #print(statType)
                        statNum = str(line)[two_pos + len('">'):three_pos]
                        #if lname is not None: 
                            #print(statType + ":" + statNum)
                        #still printing team stats and attributing them to Jshun Harris
                        #f.writerow([fname, lname, number, statType, statNum])
                        #print(fname + " " + lname + " " + statType + ":" + statNum)
                      

