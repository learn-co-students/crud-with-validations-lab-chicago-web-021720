class Song < ActiveRecord::Base
    validates_presence_of :title, :artist_name
    validates :title, uniqueness: true, if: :artist_already_released_song
    validates :released, inclusion: {in: [true, false]}
    validates :release_year, presence: true, if: :released_is_true
    validate :release_year_is_current_year_or_earlier

    def released_is_true
        self.released == true
    end
    
    def artist_already_released_song
        Song.where(artist_name: self.artist_name, release_year: self.release_year).empty? == false
    end

    def release_year_is_current_year_or_earlier
        return if self.release_year == nil
        if self.release_year > DateTime.now.year
            errors.add(:release_year, "must be current year or earlier")
        end
    end

end

# - `title`, a `string`
#   - Must not be blank
#   - Cannot be repeated by the same artist in the same year
# - `released`, a `boolean` describing whether the song was ever officially
#   released.
#   - Must be `true` or `false`
# - `release_year`, an `integer`
#   - Optional if `released` is `false`
#   - Must not be blank if `released` is `true`
#   - Must be less than or equal to the current year
# - `artist_name`, a `string`
#   - Must not be blank
# - `genre`, a `string`