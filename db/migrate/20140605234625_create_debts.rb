class CreateDebts < ActiveRecord::Migration
  def change
    create_table :debts do |t|
      t.float :amount
      t.string :debtor_name
      t.string :creditor_name
      t.string :debtor_phone
      t.string :creditor_phone
      t.string :message
      t.boolean :active

      t.timestamps
    end
  end
end
