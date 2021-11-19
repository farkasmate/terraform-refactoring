# frozen_string_literal: true

require 'logger'
require 'json'
require 'aws-sdk-lambda'
require 'aws-sdk-s3'

def client_params
  return {} unless ENV['LOCALSTACK_HOSTNAME'] && ENV['LOCALSTACK_PORT']

  { endpoint: "http://#{ENV['LOCALSTACK_HOSTNAME']}:#{ENV['LOCALSTACK_PORT']}" }
end

def lambda_handler(*)
  logger = Logger.new($stdout)
  s3 = Aws::S3::Client.new(client_params)

  logger.info("BUCKETS: #{s3.list_buckets.buckets.collect(&:name).to_json}")
end

lambda_handler if __FILE__ == $PROGRAM_NAME
