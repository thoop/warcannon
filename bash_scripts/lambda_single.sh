#! /bin/bash

if [[ -f __/spot_request.json ]]; then
	echo "You must run this from the warcannon folder."
	exit 1
fi


if [[ ! -f spot_request.json ]]; then
	echo "You must run terraform first!"
	exit 1
fi

if [[ "$#" -lt 1 ]]; then
	echo "You must specify a warc path."
	echo "e.g. $0 crawl-data/CC-MAIN-2020-34/segments/1596439735792.85/warc/CC-MAIN-20200803083123-20200803113123-00033.warc.gz"
	exit 1
fi

aws --profile $(jq -r '.awsProfile' settings.json) --region us-east-1 lambda invoke --function-name warcannon --payload "{\"warc\":\"$1\"}" /dev/stdout
# crawl-data/CC-MAIN-2020-34/segments/1596439735792.85/warc/CC-MAIN-20200803083123-20200803113123-00033.warc.gz