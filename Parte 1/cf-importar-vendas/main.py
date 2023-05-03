import base64
import json
import os
from google.cloud import pubsub_v1
import pandas as pd
from google.cloud import storage

publisher = pubsub_v1.PublisherClient()
PROJECT_ID = "poised-artwork-385111"


def cloud_function(event, callback):
    data = ''
    print('INICIO')
    
    read_file = pd.read_excel(event['mediaLink'], parse_dates = False)
    rec = read_file.to_dict(orient='records')
    
   
    if data is None:
        print("request.data is empty")
        return ("request.data is empty", 400)

    vendas = []
    for r in rec:
        date = r['DATA_VENDA'].strftime("%Y/%m/%d")
        print(date)
        vendas.append({
        "idMarca": r['ID_MARCA'],
        "idLinha":r['ID_LINHA'],
        "dataVenda": date,
        "qtdVenda": r['QTD_VENDA'],
        "ano":r['DATA_VENDA'].year,
        "mes":r['DATA_VENDA'].month  })
        
    
    print(vendas)
    topic_path = "projects/poised-artwork-385111/topics/importar-vendas"


    message_json = json.dumps(vendas)
    message_bytes = message_json.encode("utf-8")

    try:
        publish_future = publisher.publish(topic_path, data=message_bytes)
        publish_future.result()

    except Exception as e:
        print(e)
        return (e, 500)

    return ("Message received and published to Pubsub", 200)
