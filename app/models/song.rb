class Song < ApplicationRecord
    validates :title, presence: true
    validates :release_year, presence: true, if: :released
    validate :release_year_cannot_be_in_the_future
    validates :title, uniqueness: true, if: :release_year_is_the_same
    
    

    def release_year_is_the_same
        Song.all.any? { |s| s.release_year == self.release_year }
    end  




    def release_year_cannot_be_in_the_future
      if self.release_year.present? && self.release_year > DateTime.now.year
        self.errors.add(:release_year, "can't be in the future")
      end
    end    
 

end


