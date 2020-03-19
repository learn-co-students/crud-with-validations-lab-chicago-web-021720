class SongsController < ApplicationController

    def index
        @songs = Song.all
    end

    def show
        find_song
    end 

    def new
        @song = Song.new
    end 

    def create
        @song = Song.new(get_params)
        if @song.save
            redirect_to song_path(@song)
        else
            render :new
        end 
    end

    def edit
        find_song
    end

    def update
        find_song.assign_attributes(get_params)
        if @song.save
            redirect_to song_path(@song)
        else
            render :edit
        end 
    end 

    def destroy
        find_song.destroy
        redirect_to songs_path
    end 

    private

    def find_song
        @song = Song.all.find(params[:id])
    end 

    def get_params
        params.require(:song).permit(:title, :artist_name, :release_year, :released, :genre)
    end 
end
