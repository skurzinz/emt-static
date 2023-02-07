import glob
import os
import csv
from acdh_tei_pyutils.tei import TeiReader
from tqdm import tqdm

faulty = []
files = sorted(glob.glob('./data/*/*.xml'))
for x in tqdm(files, total=len(files)):
    _, tail = os.path.split(x)
    try:
        doc = TeiReader(x)
    except Exception as e:
        faulty.append([tail, e])
        os.remove(x)

with open('./html/faulty.csv', 'w', newline='') as csvfile:
    my_writer = csv.writer(csvfile, delimiter=',')
    my_writer.writerow(['path', 'error'])
    for x in faulty:
        my_writer.writerow([x[0], x[1]])