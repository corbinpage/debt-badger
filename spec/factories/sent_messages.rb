# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sent_message do
    message "MyText"
    to "MyString"
    from "MyString"
    status "MyString"
    debt nil
  end
end
