class AdminMailer < ApplicationMailer
    default from: 'contacto@fragmentx.org'

    layout 'mailer'

    def new_registration(email)
        @email = email
        mail(to: 'contacto@fragmentx.org', subject: 'New user registration')
    end
end
