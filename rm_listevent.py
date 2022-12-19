import glob
from tqdm import tqdm
from acdh_tei_pyutils.tei import TeiReader

files = sorted(glob.glob("./data/editions/*.xml"))
print(f"removing listevents from {len(files)} edition files")

for x in tqdm(files, total=len(files)):
    try:
        doc = TeiReader(x)
    except:
        continue
    for bad in doc.any_xpath(".//tei:back//tei:listEvent"):
        bad.getparent().remove(bad)
    doc.tree_to_file(x)


files = sorted(glob.glob("./data/indices/*.xml"))
print(f"removing listevents from {len(files)} indices files")

for x in tqdm(files, total=len(files)):
    try:
        doc = TeiReader(x)
    except:
        continue
    for bad in doc.any_xpath(".//tei:body//tei:listEvent"):
        bad.getparent().remove(bad)
    doc.tree_to_file(x)
