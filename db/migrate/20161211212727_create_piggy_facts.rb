class CreatePiggyFacts < ActiveRecord::Migration[5.0]
  def change
    create_table :piggy_facts do |t|
      t.text :fact
      t.datetime :last_used

      t.timestamps
    end
  end
end
