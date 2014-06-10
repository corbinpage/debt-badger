class Debt < ActiveRecord::Base
  has_many :sent_messages

  # attr_accessor :amount,
  #               :debtor_name,
  #               :creditor_name,
  #               :debtor_phone,
  #               :creditor_phone,
  #               :message,
  #               :active

  def self.start_new(debt_params)
    new_debt = Debt.new(debt_params)

    new_debt.send_creditor_onboarding_message

    new_debt.active = true
    new_debt
  end

  def send_creditor_onboarding_message
    message_one = "Hey #{self.creditor_name}, DebtBadger here!"
    message_two = "I'll be sending #{self.debtor_name} a reminder text everyday until you get paid. Just text STOP back to this number when you're paid. kthxbye!"
    
    self.sent_messages << SentMessage.send_message_to_number(message_one, self.creditor_phone)
    self.sent_messages << SentMessage.send_message_to_number(message_two, self.creditor_phone)
  end

  def sent_automated_message
    SentMessage.send_message_to_number(self.message, self.debtor_phone, self.id)
  end

  def self.send_automated_messages
    active_debts = Debt.where(active: true)

    active_debts.each do |d|
      d.sent_automated_message
    end

  end



end
