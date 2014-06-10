class CreateSentMessages < ActiveRecord::Migration
  def change
    create_table :sent_messages do |t|
      t.text :message
      t.string :to
      t.string :from
      t.string :status
      t.references :debt, index: true

      t.timestamps
    end
  end
end
