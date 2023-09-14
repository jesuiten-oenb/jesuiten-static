# Jesuiten Littera annuae


* build with [DSE-Static-Cookiecutter](https://github.com/acdh-oeaw/dse-static-cookiecutter)


## local development

* go to vs-code
* hit `ctrl-shift-ö` to open terminal
* run `.\fetch_data.sh` to fetch the latest version of the data from GitHub
* run `ant` to build your beautiful website (or in Oxagen open `build.xml`) and click the play button

### translations

Translations are curated in `translations.csv` (who would have thought). After any modification of this `.csv` you'll need to run `python make_translations.py`

### development server

In order to properly test/experience your local web-app you'll need to run a webserver. To do so,
* change directory into `html` folder (`cd html`)
* and run `python -m http.server`. 
* This starts a simple web server and you can know admire your work under [http://localhost:8000/](http://localhost:8000/)