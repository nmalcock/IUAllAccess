import requests
from bs4 import BeautifulSoup
import csv
###names with II or IV need to remove II or IV for stats scrapers 
url = "https://iuhoosiers.com/roster.aspx?path=baseball"
page = requests.get(url, headers={'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.47 Safari/537.36'})

soup = BeautifulSoup(page.content, 'html.parser')

player = soup.find_all('li',"sidearm-roster-player")

entry = []

fieldnames = ['fname','lname','number','position','year','height','weight','hometown','highschool','image_path','teamID']
with open('Baseroster.csv', mode="w") as s:
    writer = csv.writer(s, delimiter=',')
    writer.writerow(fieldnames)

    for item in player:
        name = item.find('p')
        full_name = name.find('a').getText()
        split_name = full_name.find(' ')
        fname = full_name[:(split_name)]
        lname = full_name[(split_name + 1):]
        #print(fname, " ", lname)
        lastname = lname.replace(" ", "")
        laname = lastname.replace("II", "")
        lasname = laname.replace("III", "")
        lname = lasname.replace("IV", "")
        
        
    
        print(lname, fname)
        entry.append(fname)
        entry.append(lname)

        number = item.find(class_="sidearm-roster-player-jersey-number").getText()
        #print(number)
        entry.append(number)
        
        position = item.find(class_="text-bold").getText()
        #print(len(position),":", number)
        #fixing double position entry
        if len(position) > 150:
            new_position = position.strip()
            position = new_position[0:3]
            #print(position, ":", number)
##            one_position = position.find("sidearm-roster-player-position-long-short hide-on-medium")
##            print(one_position)
##            if one_position == None:
##                position = position.strip()
##                print(position)
##            else:
##                None
                
            #print(position, ":", one_position)
##            print(one_position)
##            position = one_position.find(">").getText()
            
        else:
            position = position.strip()
            #print(position, " ", number)
    
        entry.append(position)

        year = item.find(class_="sidearm-roster-player-academic-year hide-on-large").getText()
        #print(position, ":", number, " ", year)
        entry.append(year)
        

        #Add Height & Weight in DB
        height = item.find(class_="sidearm-roster-player-height").getText()
        entry.append(height)
        #print(entry)
        

        weight = item.find(class_="sidearm-roster-player-weight").getText()

        #print(position, ":", number, " ", year, " ", height, " ", weight)
        entry.append(weight)
        

        #Add Hometown & Highschool in DB
        hometown = item.find(class_="sidearm-roster-player-hometown").getText()
        entry.append(hometown)
        
    
        highschool = item.find(class_="sidearm-roster-player-highschool")
##        print(highschool)
        #for transfer players that don't have a listed HS
        if highschool == None:
            highschool = item.find(class_="sidearm-roster-player-previous-school").getText()
        else:
            
            highschool = highschool.getText()
        entry.append(highschool)

        

        #print(fname, " ", lname, " ", hometown, " ", highschool)

        #print(fname, " ", lname, " ", hometown, " ", highschool, " ", position, ":", number, " ", year, " ", height, " ", weight)

        img = item.find(class_="sidearm-roster-player-image column")
        image = img.find('img')
        image1 = image.get('data-original')
        image_path = "https://iuhoosiers.com" + image1
        #print(fname, lname, image_path)
        entry.append(image_path)

        #print(len(image_path))

        #TEAM ID
        teamID = 3
        entry.append(teamID)
    
        #print(fname, lname, number, position, year, height, weight, hometown, highschool, image_path)
        #print(entry)
        #print(height)
        writer.writerow(entry)
        print(entry)
        
        entry = []



