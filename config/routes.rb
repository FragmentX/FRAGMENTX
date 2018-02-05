Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  HighVoltage.configure do |config|
    config.home_page = 'index'
  end

end
