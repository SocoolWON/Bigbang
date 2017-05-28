CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     'AKIAI7MUQOWVWSCMJ4LA',                        # required
    aws_secret_access_key: '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',                        # required
    region:                'ap-northeast-2',                  # optional, defaults to 'us-east-1'
    #host:                  's3.example.com',             # optional, defaults to nil
    endpoint:              'http://s3.ap-northeast-2.amazonaws.com' # optional, defaults to nil
  }
  config.fog_directory  = 'tinytalk-bucket'                          # required
  config.fog_public     = false                                        # optional, defaults to true
  #config.fog_attributes = { cache_control: "public, max-age=#{365.day.to_i}" } # optional, defaults to {}
end

