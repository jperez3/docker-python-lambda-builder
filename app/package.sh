#!/bin/bash

cd /app
rm -f /app/lambda/lambda.zip

mkdir /lambda
cp -r /app/lambda/* /lambda
cd /lambda

### Install pip dependencies 
pipenv install --deploy && cp -r $(pipenv --venv)/lib/python3.7/site-packages/. ./

### Remove unnecessary files
find . -type f -iname '*.pyc' -delete -o -type d -name __pycache__ -delete && rm Pipfile*

#rm -rf lexicon/tests/providers

### Zip lambda to be uploaded
zip -r /app/lambda/lambda.zip .

### clean up time
cd /tmp
rm -rf /lambda
