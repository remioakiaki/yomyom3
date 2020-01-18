if Rails.env.development?                                                                                                                   
  CarrierWave.configure do |config|
  #developmentのもろもろの設定
  require 'carrierwave/storage/abstract'
  require 'carrierwave/storage/file'
  require 'carrierwave/storage/fog'

  config.storage :fog
  config.fog_provider = 'fog/aws'
  config.fog_directory  = 's3bucket1206'
  config.fog_public = false
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key:ENV['AWS_SECRET_ACCESS_KEY'] ,
    region: 'ap-northeast-1',
    path_style: true
  }


  config.cache_storage = :fog
  end 
elsif Rails.env.test?
  CarrierWave.configure do |config|
    # testのもろもろの設定
  end 
else
  CarrierWave.configure do |config|
    require 'carrierwave/storage/abstract'
    require 'carrierwave/storage/file'
    require 'carrierwave/storage/fog'
  
    config.storage :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory  = 's3bucket1206'
  
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key:ENV['AWS_SECRET_ACCESS_KEY'] ,
      region: 'ap-northeast-1',
      path_style: true
    }
  
    config.fog_directory  = 's3bucket1206'
    config.cache_storage = :fog
  end
end