class CreateUserGameweekJoiners < ActiveRecord::Migration[6.0]
  serialize :ff_player_ids, Array
  def change
    create_table :user_gameweek_joiners, id: false do |t|
      t.integer :ug_id, primary_key: true 
      t.integer :total_points, null: false
      t.integer :user_id, null: false
      t.integer :gameweek_id, null: false
      
      t.timestamps
    end
  end
end
