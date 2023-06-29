import csv
import glob
import os
import json
from acdh_tei_pyutils.tei import TeiReader
from tqdm import tqdm
files = sorted(glob.glob('./data/editions/*.xml'))
out_file = "./html/js-data/calendarData.js"
data = []
no_dates = []
for x in tqdm(files, total=len(files)):
    item = {}
    head, tail = os.path.split(x)
    doc = TeiReader(x)
    item['name'] = doc.any_xpath('//tei:title[@type="main"]/text()')[0]
    sent_date_node = doc.any_xpath('//tei:correspAction/tei:date')[0]
    date_vals = [value for key, value in sent_date_node.attrib.items()]
    try:
        item['startDate'] = date_vals[0]
    except IndexError:
        no_dates.append(tail)
        continue
    item['tageszaehler'] = 1
    item['id'] = tail.replace('.xml', '.html')
    data.append(item)

print(f"{len(data)} Datumsangaben aus {len(files)} extrahiert")

print(f"writing calendar data to {out_file}")
with open(out_file, 'w',  encoding='utf8') as f:
    my_js_variable = f"var calendarData = {json.dumps(data, ensure_ascii=False)}"
    f.write(my_js_variable)

no_dates_file = './html/no_dates.csv'
print(f"writing files without date to {no_dates_file}")

with open(no_dates_file, "w", newline="") as csvfile:
    my_writer = csv.writer(csvfile, delimiter=",")
    my_writer.writerow(["file_name"])
    for x in no_dates:
        my_writer.writerow([x])