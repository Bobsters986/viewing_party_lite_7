class CreateParties < ActiveRecord::Migration[7.0]
  def change
    create_table :parties do |t|
      t.integer :movie_id
      t.integer :host_id
      t.string :day
      t.string :time
      t.integer :duration

      t.timestamps
    end
  end
end