import requests
from bs4 import BeautifulSoup
from dbconnection import *

chamberList = ['House','Senate']
currentRecord = 1
pageSize = 100

#open the db cursor and clean up any existing records
cursor = CongressConn.cursor()
cursor.execute('TRUNCATE TABLE members;')

for chamber in chamberList:
    
    currentPage = 1

    if (chamber == 'House'):
        maxPages = 5
    else:
        maxPage = 2

    while currentPage <= maxPages:
        MemberUrl = 'https://www.congress.gov/search?searchResultViewType=expanded&q=%7B%22source%22%3A%22members%22%2C%22congress%22%3A%22117%22%2C%22chamber%22%3A%22' + chamber + '%22%7D&pageSize=' + str(pageSize) + '&page=' + str(currentPage)
        page = requests.get(MemberUrl)

        soup = BeautifulSoup(page.content, 'html.parser')

        ol_container = soup.find('ol', class_='basic-search-results-lists')
        records = ol_container.find_all('li', class_='compact')

        for record in records:

            print('Record: ' + str(currentRecord), end='\n')

            #reset variables
            picture = ''
            name = ''
            state = ''
            district = ''
            party = ''

            if (record.find('div', class_='member-image') ):
                picture = 'https://www.congress.gov' + record.find('div', class_='member-image').find('img').get('src')
            name = record.find('span', class_='result-heading').find('a').get_text()

            memberData = record.find('div', class_="member-profile").find_all('span', class_='result-item')

            for memberItem in memberData:
                if (memberItem.find('strong').get_text() == 'State:'):
                    state = memberItem.find('span').get_text()
                elif (memberItem.find('strong').get_text() == 'District:'):
                    district = memberItem.find('span').get_text()
                elif (memberItem.find('strong').get_text() == 'Party:'):
                    party = memberItem.find('span').get_text()
            
            #debug information
            #print(picture, end='\n')
            #print(name, end='\n')
            #print(state, end='\n')
            #print(district, end='\n')
            #print(chamber, end='\n')
            #print(party, end='\n')

            #print("DECLARE @Name varchar(512) = '" + name.replace("'", "''") + "' ; \n" +
            #    "DECLARE @district varchar(50) = '" + district + "' ; \n" +
            #    "DECLARE @state varchar(50) = '" + state + "' ; \n " +
            #    "DECLARE @party varchar(50) = '" + party + "' ; \n" +
            #    "DECLARE @picture varchar(1024) = + '" + picture + "'; \n" +
            #    "DECLARE @chamber varchar(50) = '" + chamber + "'; \n\n" +
            #        
            #    "EXEC dbo.CreateMember @Name=@Name, @district=@district, @state=@state, @picture=@picture, @chamber=@chamber, @party=@party;"     
            #,  end='\n')

            cursor.execute(
                "DECLARE @Name varchar(512) = '" + name.replace("'", "''").strip() + "' ; \n" +
                "DECLARE @district varchar(50) = '" + district.strip()+ "' ; \n" +
                "DECLARE @state varchar(50) = '" + state.strip() + "' ; \n " +
                "DECLARE @party varchar(50) = '" + party.strip() + "' ; \n" +
                "DECLARE @picture varchar(1024) = + '" + picture.strip() + "'; \n" +
                "DECLARE @chamber varchar(50) = '" + chamber.strip() + "'; \n\n" +
        
                "EXEC dbo.CreateMember @Name=@Name, @district=@district, @state=@state, @picture=@picture, @chamber=@chamber, @party=@party;"     
            )
            cursor.commit()
            
            currentRecord = currentRecord + 1

        currentPage = currentPage + 1
        
cursor.close()
CongressConn.close()

    