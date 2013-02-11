class CreateRadios < ActiveRecord::Migration
  def change
    create_table :radios do |t|
      t.string   :name
      t.datetime :started_at
      t.datetime :ended_at

      t.timestamps
    end
  end
end
