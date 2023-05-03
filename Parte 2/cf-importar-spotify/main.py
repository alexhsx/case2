import requests
import base64
import os
import pymysql
from secrets import *

# Step 1 - Authorization 
url = "https://accounts.spotify.com/api/token"
headers = {}
data = {}
clientId = 'e189ba9d6b95480b9e2ff99cce19b0df'
clientSecret = '27d7e4a05bd7427f9643a7d0c7d07780'
dataHackersId = '1oMIHOXsrLFENAeM743g93'
searchQuery = "data%20hackers"
searchShow = f"https://api.spotify.com/v1/search?query={searchQuery}&type=show&include_external=audio&market=BR&offset=0&limit=50"
def geraToken():
  message = f"{clientId}:{clientSecret}"
  messageBytes = message.encode('ascii')
  base64Bytes = base64.b64encode(messageBytes)
  base64Message = base64Bytes.decode('ascii')
  headers['Authorization'] = f"Basic {base64Message}"
  data['grant_type'] = "client_credentials"
  r = requests.post(url, headers=headers, data=data)
  return r.json()['access_token']


def inserir(tabela5, tabela6, tabela7):
    print('INSERIR')
    connection = pymysql.connect(host='10.28.128.4',
                                user='root',
                                password=os.environ["DB_PASS"],
                                database='db_spotify',
                                cursorclass=pymysql.cursors.DictCursor)
    with connection:
        with connection.cursor() as cursor:
            cursor.execute(f"TRUNCATE TABLE tabela5")
            cursor.execute(f"TRUNCATE TABLE tabela6")
            cursor.execute(f"TRUNCATE TABLE tabela7")
            
            cursor.executemany("INSERT INTO tabela5 (`name`, `description`, `id`, `total_episodes`) VALUES (%s, %s, %s, %s)", tabela5)
            cursor.executemany("INSERT INTO tabela6 (`id`, `name`, `description`, `release_date`, `duration_ms`, `language`, `explicit`, `type`) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)", tabela6)
            cursor.executemany("INSERT INTO tabela7 (`id`, `name`, `description`, `release_date`, `duration_ms`, `language`, `explicit`, `type`) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)", tabela7)
            
            connection.commit()            
            return {"results": "ok"}

def geraTabela5(head):
  print('tabela 5 inicio')
  tabela5 = []
  urlGet = searchShow
  while urlGet is not None:
    res = requests.get(url=urlGet, headers=head)
    result = res.json()
    for item in result['shows']['items']:
      tabela5.append((item["name"], item["description"], item["id"], item["total_episodes"]))
      urlGet = None
    #urlGet = result['shows']['next'] 
    
  print('tabela 5 fim')
  return tabela5
  #inserir('tabela5', "INSERT INTO tabela5 (name, description, id, total_episodes) VALUES (%s, %s, %s, %s)", tabela5)

def geraTabela67(head):
  print('tabela 6 7 inicio')
  tabela6 = []
  tabela7 = []
  urlGet = f"https://api.spotify.com/v1/shows/{dataHackersId}/episodes?offset=0&limit=50&market=BR"
  while urlGet is not None:
    res = requests.get(url=urlGet, headers=head)
    result = res.json()
    for item in result['items']:
      obj = (item["id"], item["name"], item["description"], item["release_date"], item["duration_ms"], item["language"], item["explicit"], item["type"])
      tabela6.append(obj)
      if "Boticario" in item["description"] or "Boticário" in item["description"]:
        tabela7.append(obj)
        
    urlGet = result['next'] 

  print('tabela 6 7 fim')
  return { "tabela6": tabela6,
          "tabela7": tabela7}
  #inserir('tabela6', "INSERT INTO tabela6 (id, name, description, release_date, duration_ms, language, explicit, type) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)", tabela6)
  #inserir('tabela6', "INSERT INTO tabela7 (id, name, description, release_date, duration_ms, language, explicit, type) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)", tabela7)

def cloud_function(request):
  print('INICIO PROCESSO')
  token = geraToken()
  headers = {
    "Authorization": "Bearer " + token
   }
  tabela5 = geraTabela5(headers)
  print(tabela5)
  tabelas = geraTabela67(headers)
  print(tabelas)
  inserir(tabela5=tabela5, tabela6=tabelas["tabela6"], tabela7=tabelas["tabela7"])
  print('FIM PROCESSO')
  return ("Dados do Spotify foram importados!", 200)

