CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: Settings.s3.access_key,
    aws_secret_access_key: Settings.s3.secret_access_key,
    region: Settings.s3.region
  }

    case Rails.env
    when 'development'
        config.fog_directory  = Settings.s3.fog_directory
        config.asset_host = Settings.s3.asset_host
        config.storage = :fog
    when 'production'
        config.fog_directory  = Settings.s3.fog_directory
        config.asset_host = Settings.s3.asset_host
        config.storage = :fog
    when 'test'
        config.storage = :file
    end
end
