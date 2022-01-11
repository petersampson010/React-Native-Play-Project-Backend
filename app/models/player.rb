class Player < ApplicationRecord

    has_many :records
    
    has_many :player_gameweek_joiners
    has_many :gameweeks, through: :player_gameweek_joiners

    # has_one :admin_user, through: :users

    

end
