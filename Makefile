default:
	make up

docker-build: 
	docker build . -t 3dna/python-lambda-builder:latest

docker-run:
	docker run \
	--rm --name lambda \
	-v $$(pwd)/lambda:/app/lambda \
	3dna/python-lambda-builder:latest

docker-up:
	make build run

docker-stop:
	docker stop lambda

docker-remove:
	docker rm lambda && docker rmi 3dna/python-lambda-builder:latest

docker-destroy:
	make stop remove

docker-debug:
	docker run -it -v $$(pwd)/lambda:/app/lambda 3dna/python-lambda-builder:latest /bin/bash

lambda-upload:
	aws lambda --profile sandbox-eu update-function-code --function-name python_test3 --zip-file fileb://lambda/lambda.zip

lambda-invoke:
	aws lambda --profile sandbox-eu invoke \
    --function-name=python_test3 \
    --invocation-type=RequestResponse \
    --payload='{ "test": "value" }' \
    --log-type=Tail \
    /dev/null | jq -r '.LogResult' | base64 --decode

lambda-test:
	make docker-build docker-run lambda-upload lambda-invoke

acm-list:
	aws acm --profile sandbox-eu list-certificates		