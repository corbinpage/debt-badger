class SentMessage < ActiveRecord::Base
  belongs_to :debt

  TWILIO_ACCOUNT_ID = ENV['DEBTBADGER_TWILIO_ACCOUNT_ID']
  TWILIO_AUTH_TOKEN = ENV['DEBTBADGER_TWILIO_AUTH_TOKEN']
  FROM_NUMBER = '+17049300159'

  def self.send_message_to_number(message,number,debt_id=-1)

    begin
      client = Twilio::REST::Client.new(TWILIO_ACCOUNT_ID, TWILIO_AUTH_TOKEN)

      client.account.messages.create(
                                     from: FROM_NUMBER,
                                     to: number,
                                     body: message)
    else
      if debt_id == -1
        SentMessage.create( message: message,
                           to: number,
                           from: FROM_NUMBER,
                           status: 'OK')
      else
        SentMessage.create( message: message,
                           to: number,
                           from: FROM_NUMBER,
                           status: 'OK',
                           debt_id: debt_id)
      end
    end




  end



end
