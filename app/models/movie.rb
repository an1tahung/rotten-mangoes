class Movie < ActiveRecord::Base
  has_many :actors

  has_many :reviews

  mount_uploader :poster_image_url, ImageUploader

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :poster_image_url,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_past

  def review_average
    reviews.sum(:rating_out_of_ten)/((reviews.size).nonzero? || 1)
  end

  def self.search(title, director)
    @movies = Movie.all
    if !title.blank?
      @result = @movies.where("title LIKE ?", "%#{title}%")
    else !director.blank?
      @result = @movies.where("director LIKE ?", "%#{director}%")
    end
  end

  protected

  def release_date_is_in_the_past
    if release_date.present? && release_date > Date.today
      errors.add(:release_date, "should probably be in the past")
    end
  end
end
