class Debt < ActiveRecord::Base




  def self.start_new(debt_params)

    Debt.new(debt_params)
  end



end
