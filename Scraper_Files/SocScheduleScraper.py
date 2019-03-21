import requests
from bs4 import BeautifulSoup
import csv

url = "https://iuhoosiers.com/schedule.aspx?path=msoc"
page = requests.get(url, headers={'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.47 Safari/537.36'})

soup = BeautifulSoup(page.content, 'html.parser')

schedule = soup.find_all('li', {"sidearm-schedule-game sidearm-schedule-home-game sidearm-schedule-game-completed","sidearm-schedule-game sidearm-schedule-away-game sidearm-schedule-game-completed","sidearm-schedule-game sidearm-schedule-home-game sidearm-schedule-game-upcoming","sidearm-schedule-game sidearm-schedule-away-game sidearm-schedule-game-upcoming", "sidearm-schedule-game sidearm-schedule-neutral-game sidearm-schedule-game-completed", "sidearm-schedule-game sidearm-schedule-neutral-game sidearm-schedule-game-upcoming"})
tournament = soup.find_all('li', {"sidearm-schedule-game sidearm-schedule-neutral-game tourney sidearm-schedule-game-completed", "sidearm-schedule-game sidearm-schedule-neutral-game tourney sidearm-schedule-game-upcoming"})

big_ten = ["Rutgers (Senior Day)", "Michigan", "Ohio State", "Michigan State", "Rutgers", "Maryland", "Nebraska", "Purdue", "Illinois", "Penn State", "Minnesota", "Northwestern"]                          
entry = []
#for tournament games
location = ['"sidearm-schedule-game-home"', '"sidearm-schedule-game-away"']
#Change Change Database Drop season Change home score & away score instead of IU Opponent Score
fieldnames = ['opponent', 'date_time', 'site','home_score', 'away_score', 'bTenOpp', 'w_L', 'box_score_link','teamID']
with open('Baseschedule.csv', mode="w") as s:
    writer = csv.writer(s, delimiter=',')
    writer.writerow(fieldnames)
##    for game in tournament:
##        opponent = game.find('a').getText()
##        #print(opponent)
##        try:
##            site = game.find(style="background-color: ").getText()
##        except:
##            site = "Tourney"
##        print(site)
##    #gets tournament but not sure how to combine with other list

    for game in schedule:
        opponent = game.find('a').getText()
        #print(opponent)
        dt = game.find('a')
        dt_long = dt.get('aria-label')
        date_pos = str(dt_long).find(" on ")
        
        
        try:
            site = game.find(class_="sidearm-schedule-game-home").getText()
        except:
            site = game.find(class_="sidearm-schedule-game-away").getText()
        
        

        if site == "vs":
            site = "Home"
        else:
            site = "Away"
    
        

 

        #Checking that site is correct
        Date_Time = dt_long[(date_pos+4):]
        #print(Date_Time)
        date_split = Date_Time.split(' ')

        if date_split[0] == 'February':
            month = '02'
            year = '2019'
        elif date_split[0] == 'March':
            month = '03'
            year = '2019'
        elif date_split[0] == 'April':
            month = '04'
            year = '2019'
        elif date_split[0] == 'May':
            month = '05'
            year = '2019'
        elif date_split[0] == 'June':
            month = '06'
            year = '2019'

        if len(date_split[1]) == 1:
            day = '0' + date_split[1]
        else:
            day = date_split[1]
        date = (year + "-" + month + "-" + day)

        #print(site, date)

        time_split = date_split[2].find(':')
        #correcting for noon games
        if date_split[2] != "Noon":
            hour_pos = date_split[2][:time_split]
            time_pos = date_split[2][(time_split + 1):]    
        else:
        #lenTime = len(time_split)
        #print(time_split, " ", date)
            #print(date_split[2])
            hour_pos = 12
            time_pos = "00"
            #print(time_pos)
            #fixing times that don't list minutes
        new_hour_pos = str(hour_pos)
        if len(new_hour_pos) == 0:
            hour_pos = time_pos
            time_pos = "00"
        else:
            hour_pos = hour_pos
            time_pos = time_pos

        #print(hour_pos, ":", time_pos)
        #print(hour_pos)
        if hour_pos == None:
            hour_pos = time_pos
            time_pos = "00"
            #print(hour_pos, ":", time_pos)
        else:
            hour_pos = hour_pos
            time_pos = time_pos
        #print(hour_pos, ":", time_pos)
            
        #print(hour_pos, ":", time_pos, date)
        #print(time_pos)
##            if hour_pos is None:
##                hour_pos = time_pos
##                print(hour_pos)
##            else:
##                print("good")

        if hour_pos == 12:   
            hour = hour_pos
            minute = time_pos
            #print(minute)
            #print(hour)
        else:
            hour = int(hour_pos) + 12
            minute = time_pos
        time = (str(hour) + ":" + str(minute)+ ":" + "00")
        
        date_time = (date + " " + time)
        #checking that date time is correct
        #print(date_time)

        entry.append(opponent)
        entry.append(date_time)
        entry.append(site)

        result = game.find(class_="sidearm-schedule-game-result text-italic")
        span = str(result)[84:]
        comma = str(result).find(",")
        one = str(span).find(">")
        dash = str(span).find("-")
        two = str(span).find("</")
        home_score = str(span)[(one + 1):dash]
        away_score = str(span)[(dash + 1):two]
        w_L = str(result)[75:76]
        if w_L == "n":
            w_L = ""
        elif w_L == "":
            w_L = "Upcoming"

        #print(home_score, " ", away_score, " ", w_L)
        if home_score == "" and away_score == "":
            home_score = "0"
            away_score = "0"
        else:
            home_score = home_score
            away_score = away_score
    
        entry.append(home_score)
        entry.append(away_score)
        #print(home_score, away_score)
        if opponent in big_ten:
            bTenOpp = "Big Ten"
        else:
            bTenOpp = "Non-conference"
        
##        bigten = game.find(class_="sidearm-schedule-game-conference show-on-medium noprint")
##        try:
##            ten = bigten.getText()
##            if ten == "Big Ten":
##                bTenOpp = "Big Ten"
##        except:
##            bTenOpp = "Non-Conference"

        entry.append(bTenOpp)
        entry.append(w_L)

        box = game.find(class_="sidearm-schedule-game-links-boxscore")
        try:
            box_link = box.find('a')
            box_l = box_link.get('href')
            box_score_link = "https://iuhoosiers.com" + box_l
        except:
            box_score_link = " "
        entry.append(box_score_link)

        
        #print(opponent + " " + site + ' ' + date_time + " " + home_score + "-" + away_score + " " + bTenOpp + " " + w_L)
        #print(box_score_link)
        teamID = 4
        entry.append(teamID)
        print(entry)
        writer.writerow(entry)
        entry = []
        #print(entry)
    

