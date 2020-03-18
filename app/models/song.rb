class Song < ApplicationRecord
    validates :title, :artist_name, presence: true
    validates :title, uniqueness: true, if: :artist_already_released_song
    validates :released, inclusion: { in: [true, false] }
    validates :release_year, presence: true,
        unless: -> { released == false }
    validate :release_year_cannot_be_future
    #validate :artist_cannot_release_same_song_title_twice_yearly

    def release_year_cannot_be_future
        if release_year && release_year > Date.current.year
            errors.add(:release_year, "must be current year or prior") 
        end
    end

    def artist_already_released_song
        Song.all.where(title: title, release_year: release_year, artist_name: artist_name).empty? == false
    end
end