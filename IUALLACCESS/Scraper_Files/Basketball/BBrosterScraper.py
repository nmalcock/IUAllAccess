import requests
from bs4 import BeautifulSoup
import csv

url = "https://iuhoosiers.com/roster.aspx?path=mbball"
page = requests.get(url, headers={'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.47 Safari/537.36'})

soup = BeautifulSoup(page.content, 'html.parser')

player = soup.find_all('li',"sidearm-roster-player")

entry = []

fieldnames = ['fname', 'lname', 'number','position', 'year', 'height', 'weight', 'hometown', 'highschool', 'image_path','teamID']
with open('BBroster.csv', mode="w") as s:
    writer = csv.writer(s, delimiter=',')
    writer.writerow(fieldnames)

    for item in player:
        name = item.find('p')
        full_name = name.find('a').getText()
        split_name = full_name.find(' ')
        fname = full_name[:(split_name)]
        lname = full_name[(split_name + 1):]
        entry.append(fname)
        entry.append(lname)
        
        number = item.find(class_="sidearm-roster-player-jersey-number").getText()
        entry.append(number)
        
        position = item.find(class_="text-bold").getText()
        position = position.strip()
        entry.append(position)

        year = item.find(class_="sidearm-roster-player-academic-year hide-on-large").getText()
        entry.append(year)

        #Add Height & Weight in DB
        height = item.find(class_="sidearm-roster-player-height").getText()
        entry.append(height)

        weight = item.find(class_="sidearm-roster-player-weight").getText()
        entry.append(weight)

        #Add Hometown & Highschool in DB
        hometown = item.find(class_="sidearm-roster-player-hometown").getText()
        entry.append(hometown)
        
        highschool = item.find(class_="sidearm-roster-player-highschool").getText()
        entry.append(highschool)

        img = item.find(class_="sidearm-roster-player-image column")
        image = img.find('img')
        image1 = image.get('data-original')
        image_path = "https://iuhoosiers.com" + image1
        entry.append(image_path)

        #TEAM ID
        entry.append(1)
    
        #print(fname, lname ,number, position, year, height, weight, hometown, highschool)
        #print(entry)
        writer.writerow(entry)
        entry = []


