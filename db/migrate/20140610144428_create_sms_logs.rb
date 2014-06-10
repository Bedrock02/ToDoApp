class CreateSmsLogs < ActiveRecord::Migration
  def change
    create_table :sms_logs do |t|
      t.string :from
      t.string :body

      t.timestamps
    end
  end
end
