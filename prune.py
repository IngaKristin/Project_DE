#!/usr/bin/python3
import json
import os
import sys

DIR_IN = '/media/bjorn/HD_4TB/rc-split/'
DIR_OUT = '/media/bjorn/m2-512-0/rc-split-pruned-new/'
PRINT_STATUS_EVERY = 100000

if not os.path.exists(DIR_OUT):
    os.makedirs(DIR_OUT)

if not os.path.exists(DIR_IN):
    os.makedirs(DIR_IN)

SUBREDDITS = [
    'sweden',
]


def scan():
    for file_name in sorted(os.listdir(DIR_IN)):
        file_path_in = os.path.join(DIR_IN, file_name)
        if not file_name[:2] == 'rc':
            continue
        with open(file_path_in, 'r') as f:
            for line in f:
                try:
                    data = json.loads(line)
                    if data['subreddit'] in SUBREDDITS:
                        print(data['body'])
                except Exception as e:
                    print(e)
                    continue


def prune():
    lines_done = 0

    for file_name in sorted(os.listdir(DIR_IN)):
        if not file_name[:2] == 'rc':
            continue
        file_path_in = os.path.join(DIR_IN, file_name)
        new_file_name = f'{file_name}-pruned.json'
        file_path_out = os.path.join(DIR_OUT, new_file_name)

        if os.path.exists(file_path_out):
            print(f'File {file_path_out} already exists. Skipping.')

            continue
        print(f'Processing {file_path_in}')
        with open(file_path_in, 'r') as f:
            with open(file_path_out, 'w') as f_out:
                for line in f:
                    try:
                        data = json.loads(line, strict=False)

                        if data['body'] == '[deleted]':
                            continue
                        relevant_data = {
                            '_id': data['id'],
                            'body': data['body'],
                            'createdAt': data['created_utc'],
                            'subreddit': data['subreddit']
                        }
                        f_out.write(json.dumps(relevant_data) + '\n')
                        lines_done += 1
                    except Exception as e:
                        continue


if __name__ == "__main__":
    prune()
    #scan()
