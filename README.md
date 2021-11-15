# Terraform 1.1 - moved {} block tests

## Run localstack

```
docker-compose up
```

## AWS CLI wrapper

`./aws` is setting up necessary environment variables and parameters to run AWS CLI with `localstack`.

## Invoke Lambda

```
./aws lambda invoke --function-name lambda_function_name --log-type Tail /dev/null | jq --raw-output '.LogResult' | base64 -d
```
