import requests
from bs4 import BeautifulSoup
import csv

url = "https://iuhoosiers.com/schedule.aspx?schedule=1501"
page = requests.get(url, headers={'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.47 Safari/537.36'})

soup = BeautifulSoup(page.content, 'html.parser')

schedule = soup.find_all('li', {"sidearm-schedule-game sidearm-schedule-neutral-game tourney sidearm-schedule-game-completed","sidearm-schedule-game sidearm-schedule-home-game tourney sidearm-schedule-game-completed","sidearm-schedule-game sidearm-schedule-home-game sidearm-schedule-game-completed","sidearm-schedule-game sidearm-schedule-away-game sidearm-schedule-game-completed"})

big_ten = ["Rutgers (Senior Day)", "Michigan", "Ohio State", "Michigan State", "Rutgers", "Maryland", "Nebraska", "Purdue", "Illinois", "Penn State", "Minnesota", "Northwestern"]                          
entry = []
#for tournament games
location = ['"sidearm-schedule-game-home"', '"sidearm-schedule-game-away"']
#Change Change Database Drop season Change home score & away score instead of IU Opponent Score
fieldnames = ['opponent', 'date_time', 'site','home_score', 'away_score', 'bTenOpp', 'w_L', 'box_score_link','teamID']
with open('SocSchedule.csv', mode="w") as s:
    writer = csv.writer(s, delimiter=',')
    writer.writerow(fieldnames)

    for game in schedule:
        if game.find('a').getText() == 'Box Score':
            opponent = game.find('span','sidearm-schedule-game-opponent-name').getText()
            start = opponent.find('M')
            end = opponent.find("final")
            opponent = opponent[start:end+5]
        else:
            opponent = game.find('a').getText()
        #print(opponent)

        try:
            site = game.find(class_="sidearm-schedule-game-home").getText()
        except:
            try:
                site = game.find(class_="sidearm-schedule-game-away").getText()
            except:
                site = "Neutral"
                
        if site == "vs":
            site = "Home"
        elif site == "Neutral":
            site = "Neutral"
        else:
            site = "Away"
        dt = game.find('a')
        dt_long = dt.get('aria-label')
        date_pos = str(dt_long).find(" on ")

        Date_Time = dt_long[(date_pos+4):]
        date_split = Date_Time.split(' ')
        
        #print(date_split)
        
        if date_split[0] == 'August':
            month = '05'
            year = '2019'
        elif date_split[0] == 'September':
            month = '06'
            year = '2019'
        elif date_split[0] == 'October':
            month = '07'
            year = '2019'
        elif date_split[0] == 'November':
            month = '02'
            year = '2019'
        elif date_split[0] == 'December':
            month = '03'
            year = '2019'

            
        if len(date_split[1]) == 1:
            day = '0' + date_split[1]
        else:
            day = date_split[1]
        date = (year + "-" + month + "-" + day)
        #print(date)

        
        if date_split[2] == 'TBA':
            time = '01:00:00'
        elif date_split[2] == "Noon":
            hour = 12
            time = str(hour) + ":0" + str(00) + ":00"
        elif date_split[3] == 'PM':
            if len(date_split[2]) == 4:
                time_split = date_split[2].find(':')
                hour_pos = date_split[2][:time_split]
                time_pos = date_split[2][(time_split + 1):]
                hour = int(hour_pos) + 12
                minute = time_pos
                time = str(hour) + ":" +str(minute)+":00"
            elif len(date_split[2]) == 5:
                time_split = date_split[2].find(':')
                hour_pos = date_split[2][:time_split]
                time_pos = date_split[2][(time_split + 1):]
                if hour_pos == '12':
                    hour = int(hour_pos)
                    minute = time_pos
                    time = str(hour) + ":" +str(minute)+":00"
                else:
                    hour = int(hour_pos) + 12
                    minute = time_pos
                    time = str(hour) + ":" +str(minute)+":00"
            else:
                hour = int(date_split[2]) + 12
                time = str(hour) + ":0"+ str(00) + ":00"
        elif date_split[3] == "a.m.":
            hour = date_split[2]
            time = str(hour) + ":0" + str(00) + ":00"

        date_time = date + " " + time
        #print(opponent + " " + date_time + " " + site)

        


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

        if w_L == "T":
            w_L = "W (4-3)PK"
            
        if site == "Away":
            entry.append(away_score)
            entry.append(home_score)
        else:
            entry.append(home_score)
            entry.append(away_score)

        #print(home_score + ":"+away_score + "  " +w_L)
        
        if opponent == 'Northwestern - B1G Quarterfinals' or opponent == 'Maryland - B1G Semifinals' or opponent == 'Michigan - B1G Championship' or opponent == "Wisconsin" or opponent == "Michigan" or opponent == "Penn State" or opponent =="Minnesota" or opponent =="Illinois" or opponent =="Rutgers" or opponent =="Maryland" or opponent =="Iowa" or opponent =="Michigan State" or opponent =="Ohio State" or opponent =="Northwestern" or opponent =="Nebraska" or opponent =="Purdue" or opponent =='Big Ten Tournament' or opponent =='Rutgers (Senior Day)' or opponent =='Big Ten Tournament ':
            bTenOpp = "Big Ten"
        else:
            bTenOpp = "Non-Conference"
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

        entry.append(4)
##        print(opponent_name + " " + str(home) + ' ' + Date_Time + " " + home_score + "-" + away_score + " " + Big_Ten + " " + win)
##        print(entry)
        writer.writerow(entry)
        entry = []
        

    

