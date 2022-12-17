
add-attributes -g "./data/editions/*.xml" -b "https://id.acdh.oeaw.ac.at.at/emt"
add-attributes -g "./data/meta/*.xml" -b "https://id.acdh.oeaw.ac.at.at/emt"
python make_typesense_index.py
python make_calendar_data.py