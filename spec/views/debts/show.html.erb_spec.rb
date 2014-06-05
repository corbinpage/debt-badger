require 'rails_helper'

RSpec.describe "debts/show", :type => :view do
  before(:each) do
    @debt = assign(:debt, Debt.create!(
      :amount => 1.5,
      :debtor_name => "Debtor Name",
      :creditor_name => "Creditor Name",
      :debtor_phone => "Debtor Phone",
      :creditor_phone => "Creditor Phone",
      :message => "Message"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/Debtor Name/)
    expect(rendered).to match(/Creditor Name/)
    expect(rendered).to match(/Debtor Phone/)
    expect(rendered).to match(/Creditor Phone/)
    expect(rendered).to match(/Message/)
  end
end
