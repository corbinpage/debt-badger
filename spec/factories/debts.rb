# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :debt do
    amount 1.5
    debtor_name "MyString"
    creditor_name "MyString"
    debtor_phone "MyString"
    creditor_phone "MyString"
    message "MyString"
  end
end
