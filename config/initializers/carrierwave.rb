require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
    config.storage :fog
	config.fog_provider = 'fog/aws'
	config.fog_directory  = 'tumiagebaket'
	config.asset_host = 'https://tumiagebaket.s3-ap-northeast-1.amazonaws.com'
    config.fog_credentials = {
      provider: 'AWS',
	  use_iam_profile: true,
	  region: 'ap-northeast-1'
	}
end