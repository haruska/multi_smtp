
#include the new modules
require "smtp_tls"

ActionMailer::Base.class_eval do 
  private

  def perform_delivery_smtp(mail)
    destinations = mail.destinations
    mail.ready_to_send

    user_name_arr = smtp_settings[:user_name].to_a
    user_name = user_name_arr[rand(user_name_arr.size)]

    Net::SMTP.start(smtp_settings[:address], smtp_settings[:port], smtp_settings[:domain], 
        user_name, smtp_settings[:password], smtp_settings[:authentication]) do |smtp|
      smtp.sendmail(mail.encoded, mail.from, destinations)
    end
  end
end

