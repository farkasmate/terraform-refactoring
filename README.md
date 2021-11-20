# Terraform refactoring

Terraform 1.1 - moved {} block tests

## AWS CLI wrapper

`./aws` is setting up necessary environment variables and parameters to run AWS CLI with `localstack`.

## Run localstack

```
docker-compose up -d
```

## Package Lambda

```
cd lambda/bucket-list/
bundle install
bundle exec rake package
```

## Apply Terraform in localstack

Make sure that `terraform.tfstate*` files are cleaned up after each `localstack` restart.

```
terraform init
terraform apply -auto-approve
```

## Invoke Lambda

```
./aws lambda invoke --function-name bucket-list --log-type Tail /dev/null | jq --raw-output '.LogResult' | base64 -d
```
