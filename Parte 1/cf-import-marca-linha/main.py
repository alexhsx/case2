import pymysql
import os
import base64
import json

def cloud_function(event, context):
    print('INICIO')
    pubsub_message = base64.b64decode(event['data']).decode('utf-8')
    print(pubsub_message)
    processado = processar(json.loads(pubsub_message))
    print(processado)
    inserir(processado)
    print('FIM')

def processar(vendas):
    result =[]
    for tb in vendas:
        ind = next((i for i, item in enumerate(result) if item['idLinha'] == tb['idLinha'] and item['idMarca'] == tb["idMarca"]), -1)
        if(ind == -1):
            result.append({ 
                "idLinha": tb["idLinha"], 
                "idMarca": tb["idMarca"], 
                "qtdVenda": tb["qtdVenda"] })
        else:
            result[ind]["qtdVenda"] += tb["qtdVenda"]
        
    return result

def inserir(tab):
    print('INSERIR')

    insert = []
    delete = []
    for t in tab:
        insert.append((t["idLinha"], t["idMarca"], t["qtdVenda"]))
        delete.append((t["idLinha"], t["idMarca"]))

    connection = pymysql.connect(host='10.28.128.4',
                                user='root',
                                password=os.environ["DB_PASS"],
                                database='db_vendas',
                                cursorclass=pymysql.cursors.DictCursor)
    with connection:
        with connection.cursor() as cursor:
            cursor.executemany("DELETE FROM `tabela2` WHERE idLinha = %s AND idMarca = %s", delete)
            cursor.executemany("INSERT INTO `tabela2`(`idLinha`, `idMarca`, `qtd`) VALUES (%s, %s, %s)", insert)
            connection.commit()
            
            return {"results": "ok"}
    