import requests
from bs4 import BeautifulSoup
import csv

url = "https://iuhoosiers.com/schedule.aspx?path=mbball"
page = requests.get(url, headers={'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.47 Safari/537.36'})

soup = BeautifulSoup(page.content, 'html.parser')

schedule = soup.find_all('li', {"sidearm-schedule-game sidearm-schedule-home-game sidearm-schedule-game-completed","sidearm-schedule-game sidearm-schedule-away-game sidearm-schedule-game-completed","sidearm-schedule-game sidearm-schedule-home-game sidearm-schedule-game-upcoming","sidearm-schedule-game sidearm-schedule-away-game sidearm-schedule-game-upcoming","sidearm-schedule-game sidearm-schedule-home-game tourney sidearm-schedule-game-completed","sidearm-schedule-game sidearm-schedule-away-game tourney sidearm-schedule-game-completed","sidearm-schedule-game sidearm-schedule-neutral-game tourney sidearm-schedule-game-completed"})


entry = []

#Change Database Drop season Change home score & away score instead of IU Opponent Score
fieldnames = ['Opponent', 'Date_Time', 'Site','Home_Score', 'Away_Score', 'BTenOpp', 'Result', 'TeamID', 'Box_ScoreLink']
with open('BBschedule.csv', mode="w") as s:
    writer = csv.writer(s, delimiter=',')
    writer.writerow(fieldnames)

    for game in schedule[1:]:
        opponent_name = game.find('a').getText()
        dt = game.find('a')
        dt_long = dt.get('aria-label')
        date_pos = str(dt_long).find(" on ")

        try:
            home = game.find(class_="sidearm-schedule-game-home").getText()
        except:
            home = game.find(class_="sidearm-schedule-game-away").getText()
        if opponent_name == "Butler":
            home = "Neutral"
        elif home == "vs":
            home = "Home"
        else:
            home = "Away"

        date_time = dt_long[(date_pos+4):]
        #print(date_time)
        date_split = date_time.split(' ')

        if date_split[0] == 'November':
            month = '11'
            year = '2018'
        elif date_split[0] == 'December':
            month = '12'
            year = '2018'
        elif date_split[0] == 'January':
            month = '01'
            year = '2019'
        elif date_split[0] == 'February':
            month = '02'
            year = '2019'
        elif date_split[0] == 'March':
            month = '03'
            year = '2019'
        elif date_split[0] == 'April':
            month = '04'
            year = '2019'
            
        if len(date_split[1]) == 1:
            day = '0' + date_split[1]
        else:
            day = date_split[1]
        date = (year + "-" + month + "-" + day)
        
        time_split = date_split[2].find(':')
        hour_pos = date_split[2][:time_split]
        time_pos = date_split[2][(time_split + 1):]

        if hour_pos == '12':
            hour = hour_pos
            minute = time_pos
        else:
            hour = int(hour_pos) + 12
            minute = time_pos
        time = (str(hour) + ":" + str(minute)+ ":" + "00")
        
        Date_Time = (date + " " + time)

        entry.append(opponent_name)
        entry.append(Date_Time)
        entry.append(home)

        result = game.find(class_="sidearm-schedule-game-result text-italic")
        span = str(result)[84:]
        comma = str(result).find(",")
        one = str(span).find(">")
        dash = str(span).find("-")
        two = str(span).find("</")
        home_score = str(span)[(one + 1):dash]
        away_score = str(span)[(dash + 1):two]
        win = str(result)[75:76]

        entry.append(home_score)
        entry.append(away_score)
        
        bigten = game.find(class_="sidearm-schedule-game-conference show-on-medium noprint")
        try:
            ten = bigten.getText()
            if ten == "Big Ten":
                Big_Ten = "Big Ten"
        except:
            Big_Ten = "Non-Conference"

        entry.append(Big_Ten)
        entry.append(win)
        entry.append(2)

        box = game.find(class_="sidearm-schedule-game-links-boxscore")
        try:
            box_link = box.find('a')
            box_l = box_link.get('href')
            box_score = "https://iuhoosiers.com" + box_l
        except:
            box_score = " "
        entry.append(box_score)
        #print(opponent_name + " " + str(home) + ' ' + Date_Time + " " + home_score + "-" + away_score + " " + Big_Ten + " " + win)
        #print(entry)
        writer.writerow(entry)
        entry = []

