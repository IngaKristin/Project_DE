#!/usr/bin/env python3
import json
import os
import time
import hashlib

import mongoengine
import requests
from pymongo import MongoClient

MONGODB_URI = 'mongodb://root:fg3259prf91fni239dduSGh245@127.0.0.1:27019/?authSource=admin&readPreference=primary&appname=MongoDB%20Compass&directConnection=true&ssl=false'
DIR_IN = '/media/bjorn/m2-512-0/rc-split-pruned/'


start_at = 0
end_at = 10000000
print(f'Uploading from {start_at} to {end_at}')

def main():
    # Connect to the database
    mclient = MongoClient(MONGODB_URI)

    # Upload json to db

    files_done = 0

    # Loop through all files in the directory
    for file_name in sorted(os.listdir(DIR_IN)):
        if files_done >= end_at:
            break
        if files_done < start_at:
            files_done += 1
            continue
        insert_these = []
        file_num = int(file_name.replace('-pruned.json', '')[2:])
        if not file_name[:2] == 'rc':
            continue
        print(f'Processing {file_name}')
        file_path_in = os.path.join(DIR_IN, file_name)
        with open(file_path_in, 'r') as f:
            for line in f:
                try:
                    json_data = json.loads(line, strict=False)
                    json_data['body'] = json_data['data']
                    del json_data['data']
                except Exception as e:
                    print(e)
                    continue
                insert_these.append(json_data)
        try:
            mclient.gp9.reddit.insert_many(insert_these)
        except Exception as e:
            print(e)
            pass
        files_done += 1


if __name__ == '__main__':
    main()
