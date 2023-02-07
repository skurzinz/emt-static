python delete_faulty_files.py
add-attributes -g "./data/editions/*.xml" -b "https://id.acdh.oeaw.ac.at.at/emt"
add-attributes -g "./data/meta/*.xml" -b "https://id.acdh.oeaw.ac.at.at/emt"
denormalize-indices -f "./data/editions/*.xml" -i "./data/indices/*.xml" -m ".//*[@ref]/@ref | .//*/@source" -x ".//tei:titleStmt/tei:title[@type='main']/text()"
python rm_listevent.py
python add_mentions.py
python make_typesense_index.py
python make_calendar_data.py