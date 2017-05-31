CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     'AKIAJHRPVGFWI2Q4Y5EQ',                        # required
    aws_secret_access_key: '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',                        # required
    region:                'ap-northeast-2',                  # optional, defaults to 'us-east-1'
    endpoint:              'http://s3.ap-northeast-2.amazonaws.com' # optional, defaults to nil
  }
  config.fog_directory  = 'teacher-tinytalk'                          # required
end

