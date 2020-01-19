class AdminMailer < ApplicationMailer
    default from: 'info@fragmentx.org'

    layout 'mailer'

    def new_registration(email)
        @email = email
        mail(to: 'info@fragmentx.org', subject: 'New user registration')
    end
end
