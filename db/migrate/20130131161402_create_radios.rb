class CreateRadios < ActiveRecord::Migration
  def change
    create_table :radios do |t|
      t.string :name
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
