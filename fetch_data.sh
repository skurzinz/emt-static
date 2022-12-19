# bin/bash

echo "fetching transkriptions from emt-transkribus-export"
rm -rf data/editions
wget https://github.com/emt-project/emt-transkribus-export/archive/refs/heads/main.zip
unzip main
mv ./emt-transkribus-export-main/data/editions ./data/editions
rm main.zip
rm -rf ./emt-transkribus-export-main

echo "fetching indices from emt-entities"
rm -rf data/indices

wget https://github.com/emt-project/emt-entities/archive/refs/heads/main.zip
unzip main
mv ./emt-entities-main/indices ./data/indices
rm main.zip
rm -rf ./emt-entities-main

echo "update imprint"
./dl_imprint.sh

