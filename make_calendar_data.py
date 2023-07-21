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
    id = tail.replace(".xml", "")

    # correspAction/date
    sent_date_node = doc.any_xpath("//tei:correspAction/tei:date")[0]
    is_valid_date = False
    if 'when-iso' in sent_date_node.attrib:
        ca_date_when = sent_date_node.attrib['when-iso']
        is_valid_date = True
    elif 'when' in sent_date_node.attrib:
        ca_date_when = sent_date_node.attrib['when']
        is_valid_date = True
    else:
        no_dates.append(tail)

    if is_valid_date:
        item = {
            "id": id + ".html",
            "name": doc.any_xpath("//tei:title[@type='main']/text()")[0],
            "date": ca_date_when,
        }
        if ca_date_when in date_sorting:
            if "correspAction_date" in date_sorting[ca_date_when]:
                date_sorting[ca_date_when]["correspAction_date"].append(item)
            else:
                date_sorting[ca_date_when]["correspAction_date"] = [item]
        else:
            date_sorting[ca_date_when] = { 'correspAction_date': [item] }

    # body/date
    body_dates = doc.any_xpath("//tei:body//tei:date[@type='letter']")
    for body_date_node in body_dates:
        if 'when-iso' in body_date_node.attrib:
            body_date_when = body_date_node.attrib['when-iso']
        elif 'when' in body_date_node.attrib:
            body_date_when = body_date_node.attrib['when']
        else:
            print(f"{id}: invalid date node in body", body_date_node.attrib)
            continue
        if is_valid_date and body_date_when == ca_date_when: # ignore in-body authoring date
            continue

        body_date_item = {
            "name": "Brief erschlossen",
            "date": body_date_when,
            "id": False,
            "ref_by_id": id,
            "ref_by_date": ca_date_when if is_valid_date else None,
        }
        if body_date_when in date_sorting:
            if "referenced_date" in date_sorting[body_date_when]:
                date_sorting[body_date_when]["referenced_date"].append(body_date_item)
            else:
                date_sorting[body_date_when]["referenced_date"] = [body_date_item]
        else:
            date_sorting[body_date_when] = { "referenced_date": [body_date_item] }

data = []
max_tz = 0
max_tz_loc = None
max_tz_multi = 0
max_tz_multi_loc = None
for date, date_data in date_sorting.items():
    tageszaehler = 1
    multi_type = len(date_data) > 1
    for date_type in date_data:
        for item in date_data[date_type]:
            item['tageszaehler'] = tageszaehler
            data.append(item)
            if tageszaehler > max_tz:
                max_tz = tageszaehler
                max_tz_loc = date
            if multi_type and tageszaehler > max_tz_multi:
                max_tz_multi = tageszaehler
                max_tz_multi_loc = date
            tageszaehler += 1

print(f"Max tageszähler: {max_tz} @date {max_tz_loc}")
print(f"Multi type max tageszähler: {max_tz_multi} @date {max_tz_multi_loc}")

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
    for failName in no_dates:
        my_writer.writerow([failName])
