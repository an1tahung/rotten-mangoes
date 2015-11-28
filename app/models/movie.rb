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

  def self.search(query, duration)
    movies = Movie.all
    movies = movies.where("title LIKE ? OR director LIKE ?", "%#{query}%","%#{query}%" ) if !query.blank?
    
    case duration 
    when '1'
     movies = movies.where("runtime_in_minutes < 90")
    when '2'
     movies = movies.where("runtime_in_minutes > 90 AND runtime_in_minutes < 120 ")
    when '3'
     movies = movies.where("runtime_in_minutes > 120")
    end
    movies
  end

  protected

  def release_date_is_in_the_past
    if release_date.present? && release_date > Date.today
      errors.add(:release_date, "should probably be in the past")
    end
  end
end
