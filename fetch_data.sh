# bin/bash

echo "fetching transkriptions from emt-working-data"
rm -rf data/editions && mkdir data/editions
wget https://github.com/emt-project/emt-working-data/archive/refs/heads/main.zip
unzip main
mv -t ./data/editions/ ./emt-working-data-main/data/work-in-progress/*/*.xml
rm main.zip
rm -rf ./emt-working-data-main

echo "fetching indices from emt-entities"
rm -rf data/indices

wget https://github.com/emt-project/emt-entities/archive/refs/heads/main.zip
unzip main
mv ./emt-entities-main/indices ./data/indices
rm main.zip
rm -rf ./emt-entities-main

echo "update imprint"
./dl_imprint.sh

