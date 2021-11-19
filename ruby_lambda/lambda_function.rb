require 'logger'
require 'json'
require 'aws-sdk-lambda'
require 'aws-sdk-s3'

params = {}
if ENV['LOCALSTACK_HOSTNAME'] && ENV['LOCALSTACK_PORT']
  params = { endpoint: "http://#{ENV['LOCALSTACK_HOSTNAME']}:#{ENV['LOCALSTACK_PORT']}" }
end

$s3 = Aws::S3::Client.new(params)
$logger = Logger.new($stdout)

def lambda_handler(event:, context:)
  $logger.info("BUCKETS: #{$s3.list_buckets.buckets.collect(&:name).to_json}")
end

if __FILE__ == $PROGRAM_NAME
  lambda_handler(event: nil, context: nil)
end
