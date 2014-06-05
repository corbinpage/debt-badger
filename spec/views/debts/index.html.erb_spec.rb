require 'rails_helper'

RSpec.describe "debts/index", :type => :view do
  before(:each) do
    assign(:debts, [
      Debt.create!(
        :amount => 1.5,
        :debtor_name => "Debtor Name",
        :creditor_name => "Creditor Name",
        :debtor_phone => "Debtor Phone",
        :creditor_phone => "Creditor Phone",
        :message => "Message"
      ),
      Debt.create!(
        :amount => 1.5,
        :debtor_name => "Debtor Name",
        :creditor_name => "Creditor Name",
        :debtor_phone => "Debtor Phone",
        :creditor_phone => "Creditor Phone",
        :message => "Message"
      )
    ])
  end

  it "renders a list of debts" do
    render
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => "Debtor Name".to_s, :count => 2
    assert_select "tr>td", :text => "Creditor Name".to_s, :count => 2
    assert_select "tr>td", :text => "Debtor Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Creditor Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Message".to_s, :count => 2
  end
end
