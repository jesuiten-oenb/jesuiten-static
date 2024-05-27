# bin/bash

echo "fetching transkriptions from data_repo"
rm -rf data/editions && mkdir data/editions
rm -rf data/indices && mkdir data/indices
rm -rf data/meta && mkdir data/meta
curl -LO https://github.com/jesuiten-oenb/baserow-entities/archive/refs/heads/main.zip
unzip main

mv ./baserow-entities-main/data/editions/ ./data
mv ./baserow-entities-main/data/indices/ ./data
mv ./baserow-entities-main/data/meta/ ./data

rm main.zip
rm -rf ./baserow-entities-main