class UsersController < ApplicationController
    def index 
        users = User.all
        render json: users
    end 

    def create
        user = User.create(user_params)
        render json: user
    end 

    def show
        user = User.find(params[:id])
        render json: user
    end 

    def update
        user = User.find(params[:id])
        user.update(user_params)
        render json: user
    end

    def destroy 
        user = User.find(params[:id])
        user.delete
    end 

    def records 
        user = User.find(params[:id])
        records = Record.all.filter{|x| x.user_id===user.user_id}
        render json: records
    end 

    def latest_starters
        user = User.find(params[:id])
        players = Player.all 
        records = Record.all.filter{|x| x.user_id===user.user_id && x.sub===false}
        records_player_ids = records.map{|x| x.player_id}
        user_players = players.select{|x| records_player_ids.include?(x.player_id)}
        render json: user_players
    end 

    def gw_starters
        ug_joiners = Record.all
        user = User.find(params[:id])
        ug_joiner = user.user_gameweek_joiners.filter{|ug| ug.gameweek_id===params[:gameweek_id].to_i}[0]
        puts ug_joiner
        player_ids = ug_joiner.player_ids
        players = player_ids.map{|p| Player.all.find(p.player_id)}
        render json: players
    end 

    def latest_subs 
        user = User.find(params[:id])
        players = Player.all 
        records = Record.all.filter{|x| x.user_id===user.user_id && x.sub===true}
        records_player_ids = records.map{|x| x.player_id}
        user_players = players.select{|x| records_player_ids.include?(x.player_id)}
        render json: user_players
    end 

    def gw_subs 
        user = User.find(params[:id])
        players = Player.all 
        records = Record.all.filter{|x| x.user_id===user.user_id && x.sub===true}
        record_player_ids = records.map{|x| x.player_id}
        user_players = players.select{|x| record_player_ids.include?(x.player_id)}
        render json: user_players
    end 

    def pg_joiners
        puts 'here'
        id = params[:gameweek_id].to_i
        user = User.find(params[:id])
        puts user
        pg_joiners = user.player_gameweek_joiners.filter{|pg| pg.gameweek_id===id}
        puts pg_joiners
        puts 'after'
        render json: pg_joiners
    end 

    def total_points 
        user = User.find(params[:id])
        user_gameweek_joiners = user.user_gameweek_joiners
        total_points = user_gameweek_joiners.map{|ug| ug.total_points}.sum
        render json: total_points
    end

    private 

    def user_params 
        params.require(:user).permit!
    end 

end
