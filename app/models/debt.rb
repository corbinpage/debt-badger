class Debt < ActiveRecord::Base

  attr_accessor :active

  TWILIO_ACCOUNT_ID = ENV['DEBTBADGER_TWILIO_ACCOUNT_ID']
  TWILIO_AUTH_TOKEN = ENV['DEBTBADGER_TWILIO_AUTH_TOKEN']
  FROM_NUMBER = '+17049300159'

  def self.start_new(debt_params)
    client = Twilio::REST::Client.new(TWILIO_ACCOUNT_ID, TWILIO_AUTH_TOKEN)

    message_one = "Hey #{debt_params['creditor_name']}, DebtBadger here!"
    message_two = "I'll be sending #{debt_params['debtor_name']} a reminder text everyday until you get paid. Just text STOP back to this number when you're paid. kthxbye!"
    new_debt = Debt.new(debt_params)

    new_debt.send_creditor_sms_message(client,message_one)
    # new_debt.send_creditor_sms_message(client,message_two)

    new_debt.active = true
    new_debt
  end

   
  def send_creditor_sms_message(client, message)
    client.account.messages.create(
                                    :from => FROM_NUMBER,
                                    :to => self.creditor_phone,
                                    :body => message)
  end

end
