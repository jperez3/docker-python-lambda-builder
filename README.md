
# docker-python-lambda-builder

builds python lambda functions without ec2 instance


## General

* Directions:
    - Build container `make build`
    - Create directory called `lambda` in your lambda repo with the following files:

```
$ tree lambda/
lambda/
├── Pipfile
├── Pipfile.lock
└── app.py
```

    - Run container `make run`
    - Upload lambda `aws lambda --profile sandbox-eu update-function-code --function-name python_test --zip-file fileb://lambda/lambda.zip`


##### Container Usage

* Build Container: `make docker-build`
* Run Container: `make docker-run`
    * **Expects `lambda` folder in current directory**
* Build and Run Container: `make docker-up`
    * **Expects `lambda` folder in current directory**
* Stop Container: `make docker-stop`
* Remove Container: `make docker-remove`
* Stop and Remove Container: `make docker-destroy`
* Debug Container: `make docker-debug`

#### Testing



#### To-Do

* Set up and test SAM local lambda development
* testing?



#### Resources

* [An Easier way to build AWS Lambda deployment packages](https://blog.quiltdata.com/an-easier-way-to-build-lambda-deployment-packages-with-docker-instead-of-ec2-9050cd486ba8)
* [Serverless Slash Commands](https://renzo.lucioni.xyz/serverless-slash-commands-with-python/)
* [Serverless-Artillery](https://github.com/nordstrom/serverless-artillery)
* [Package AWS Lambda Python Code With Docker](https://www.giladpeleg.com/blog/package-aws-lambda-python-code-with-docker/)
* [A Guide to Pipenv](https://realpython.com/pipenv-guide/#the-pipfile)