echo "fetching transkriptions from baserow-entities"
rm -rf data/editions && mkdir data/editions
rm -rf data/indices && mkdir data/indices
curl -LO https://github.com/jesuiten-oenb/baserow-entities/archive/refs/heads/main.zip
unzip main
mv ./baserow-entities-main/data/editions/ ./data
mv ./baserow-entities-main/data/indices/ ./data
rm main.zip
rm -rf ./baserow-entities-main