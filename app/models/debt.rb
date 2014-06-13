class Debt < ActiveRecord::Base
  has_many :sent_messages

  # attr_accessor :amount,
  #               :debtor_name,
  #               :creditor_name,
  #               :debtor_phone,
  #               :creditor_phone,
  #               :message,
  #               :active

  def self.start_new(debt_params,request_url)
    new_debt = Debt.create(debt_params)

    new_debt.send_creditor_onboarding_message(request_url)

    new_debt.active = true
    new_debt
  end

  def send_creditor_onboarding_message(request_url)
    message_array = []
    message_array[0] = "Hey #{self.creditor_name}, MoneyBadger here! We're here to help track down your #{ActionController::Base.helpers.number_to_currency(self.amount)}."
    message_array[1] = "We'll be sending #{self.debtor_name} a reminder text everyday until you get your money! Just go to the link below and cancel the texts once you're paid!"
    message_array[2] = "#{request_url}/#{self.id}"
    
    message_array.each do |message|
      self.sent_messages << SentMessage.send_message_to_number(message, self.creditor_phone)
      sleep(0.3)
    end
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

  def deactivate
    # self.active = !self.active
    self.active = false
    self.save
  end



end
