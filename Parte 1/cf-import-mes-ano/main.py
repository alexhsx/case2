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
        ind = next((i for i, item in enumerate(result) if item['ano'] == tb['ano'] and item['mes'] == tb["mes"]), -1)
        if(ind == -1):
            result.append({ 
                "ano": tb["ano"], 
                "mes": tb["mes"], 
                "qtdVenda": tb["qtdVenda"] })
        else:
            result[ind]["qtdVenda"] += tb["qtdVenda"]
        
    return result

def inserir(tab):
    print('INSERIR')

    insert = []
    delete = []
    for t in tab:
        insert.append((t["ano"], t["mes"], t["qtdVenda"]))
        delete.append((t["ano"], t["mes"]))

    connection = pymysql.connect(host='10.28.128.4',
                                user='root',
                                password=os.environ["DB_PASS"],
                                database='db_vendas',
                                cursorclass=pymysql.cursors.DictCursor)
    with connection:
        with connection.cursor() as cursor:
            cursor.executemany("DELETE FROM `tabela1`WHERE ano = %s AND mes = %s", delete)
            cursor.executemany("INSERT INTO `tabela1`(`ano`, `mes`, `qtd`) VALUES (%s, %s, %s)", insert)
            connection.commit()
            
            return {"results": "ok"}
    