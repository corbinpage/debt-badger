json.array!(@debts) do |debt|
  json.extract! debt, :id, :amount, :debtor_name, :creditor_name, :debtor_phone, :creditor_phone, :message
  json.url debt_url(debt, format: :json)
end
