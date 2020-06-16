class Settings < Settingslogic
  config_source = Rails.root / 'config' / 'application.yml'
  source config_source.to_path
  namespace Rails.env
end