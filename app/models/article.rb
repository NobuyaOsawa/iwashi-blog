class Article < ApplicationRecord

  mount_uploader :image, ImageUploader

  has_many :comments, dependent: :destroy
  validates :title,
    presence: true,
    length: { minimum: 5 }

  def previous
    Article.where("id < ?", self.id).order("id DESC").first
  end

  def next
    Article.where("id > ?", self.id).order("id ASC").first
  end

end
