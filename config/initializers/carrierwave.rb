require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
	  use_iam_profile: true,
	  region: 'ap-northeast-1'
	}
end