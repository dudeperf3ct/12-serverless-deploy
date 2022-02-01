# Serverless

In this exercise, transformers sentiment classifier fastapi application is deployed using two ways

1. [Serverless Framework](https://www.serverless.com/framework/docs)
2. [Serverless Cloud](https://www.serverless.com/cloud/docs)

## Serverless Framework

[Serverless Framework](https://www.serverless.com/framework/docs) provides hassle free develop, deploy, troubleshoot and secure serverless applications.

Under the hood, the Serverless Framework is deploying your code to a cloud provider like AWS, Microsoft Azure, Google Cloud Platform, Apache OpenWhisk, Cloudflare Workers, or a Kubernetes-based solution like Kubeless.

Pre-requisites

- AWS CLI
- Serverless Framework installed and [AWS configured](https://www.serverless.com/framework/docs/providers/aws/cli-reference/config-credentials)

## Run

### Locally

Test the sentiment classifier model

```bash
docker build -t sentiment -f project/sentiment/Dockerfile.sentiment project/sentiment/
docker run --rm -it sentiment
```

Run tests using `pytest`

```bash
docker build -t sentiment -f Dockerfile.test .
docker run -p 8000:8000 -it -v $(pwd):/app --entrypoint bash sentiment
pytest --cov
```

Build a docker image and test the application that will be used to deploy as AWS Lambda function.

```bash
docker build -t sentiment -f Dockerfile.prod .
docker run -p 8000:8000 sentiment
```

```bash
curl -X 'POST' \
  'http://0.0.0.0:8000/classify?input_text=i%20like%20you' \
  -H 'accept: application/json' \
  -d ''
```
### Deploy using serverless

Reference: [Serverless Docker deploy](https://www.serverless.com/blog/container-support-for-lambda) 

We will now deploy this application using serverless. This will add the application to Monitor on serverless dashboard.

```bash
# add monitoring to serverless dashboard
serverless
```

Deploy the application using Serverless Framework.

```bash
serverless deploy
```

Follow the instructions to deploy the application on AWS. Once application is deployed, get information about deployment.

```bash
serverless info
```

Test application

```bash
curl -i <api-endpoint>
```

Fetch logs

```bash
serverless logs -f hello
```

Remove service

```bash
serverless remove
```

Use serverless CI/CD for github


## Serverless Cloud


