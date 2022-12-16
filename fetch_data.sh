# bin/bash

rm -rf data/editions
wget https://github.com/emt-project/emt-transkribus-export/archive/refs/heads/main.zip
unzip main

mv ./emt-transkribus-export-main/data/editions ./data/editions
rm main.zip
rm -rf ./emt-transkribus-export-main

echo "update imprint"
./dl_imprint.sh

