if defined? Rack::Cors
    Rails.configuration.middleware.insert_before 0, Rack::Cors do
        allow do
            origins %w[
                https://s3-eu-west-1.amazonaws.com
                http://s3-eu-west-1.amazonaws.com
                https://scanviewer.herokuapp.com
                http://scanviewer.herokuapp.com
            ]
            resource '*'
        end
    end
end