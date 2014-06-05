require 'rails_helper'

RSpec.describe "debts/edit", :type => :view do
  before(:each) do
    @debt = assign(:debt, Debt.create!(
      :amount => 1.5,
      :debtor_name => "MyString",
      :creditor_name => "MyString",
      :debtor_phone => "MyString",
      :creditor_phone => "MyString",
      :message => "MyString"
    ))
  end

  it "renders the edit debt form" do
    render

    assert_select "form[action=?][method=?]", debt_path(@debt), "post" do

      assert_select "input#debt_amount[name=?]", "debt[amount]"

      assert_select "input#debt_debtor_name[name=?]", "debt[debtor_name]"

      assert_select "input#debt_creditor_name[name=?]", "debt[creditor_name]"

      assert_select "input#debt_debtor_phone[name=?]", "debt[debtor_phone]"

      assert_select "input#debt_creditor_phone[name=?]", "debt[creditor_phone]"

      assert_select "input#debt_message[name=?]", "debt[message]"
    end
  end
end
