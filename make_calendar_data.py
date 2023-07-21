import csv
import glob
import os
import json
from acdh_tei_pyutils.tei import TeiReader
from tqdm import tqdm
fileList = sorted(glob.glob("./data/editions/*.xml"))
out_file = "./html/js-data/calendarData.js"

date_sorting = {}
no_dates = []
for fileName in tqdm(fileList, total=len(fileList)):
    doc = TeiReader(fileName)
    head, tail = os.path.split(fileName)

    # correspAction/date
    item = {}
    item["name"] = doc.any_xpath("//tei:title[@type='main']/text()")[0]
    sent_date_node = doc.any_xpath("//tei:correspAction/tei:date")[0]
    date_vals = [value for key, value in sent_date_node.attrib.items()]
    is_valid_date = False
    try:
        item["date"] = date_vals[0]
        is_valid_date = True
    except IndexError:
        no_dates.append(tail)
    if is_valid_date:
        item["tageszaehler"] = 1
        item["id"] = tail.replace(".xml", ".html")
        if hasattr(date_sorting, item["date"]):
            date_sorting[item["date"]].correspAction_date = item
        else:
            date_sorting[item["date"]] = { 'correspAction_date': item }

    # body/date
    body_dates = doc.any_xpath("//tei:body//tei:date[@type='letter']")
    for body_date_node in body_dates:
        date_vals = [value for key, value in body_date_node.attrib.items()]
        date = None
        try:
            date_val = date_vals[0]
        except IndexError:
            continue
        if is_valid_date and date_val == item["date"]: # ignore in-body authoring date
            continue
        body_date_item = {
            "name": "Brief erschlossen",
            "date": date_val,
            "tageszaehler": 2,
            "id": False,
        }
        if hasattr(date_sorting, date_val):
            date_sorting[date_val]["referenced_date"] = body_date_item
        else:
            date_sorting[date_val] = { "referenced_date": body_date_item }

data = []
for date, date_data in date_sorting.items():
    for key in date_data:
        data.append(date_data[key])

print(f"{len(data)} Datumsangaben aus {len(fileList)} extrahiert")

print(f"writing calendar data to {out_file}")
with open(out_file, "w",  encoding="utf8") as f:
    my_js_variable = f"var calendarData = {json.dumps(data, ensure_ascii=False)}"
    f.write(my_js_variable)

no_dates_file = "./html/no_dates.csv"
print(f"writing files without date to {no_dates_file}")

with open(no_dates_file, "w", newline="") as csvfile:
    my_writer = csv.writer(csvfile, delimiter=",")
    my_writer.writerow(["file_name"])
    for x in no_dates:
        my_writer.writerow([x])
