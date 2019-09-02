class Article < ApplicationRecord

  # 画像アップロード機能のgem「CarrierWave」で必要な記述
  mount_uploader :image, ImageUploader

  # タグ機能のgem「acts-as-taggable-on」で必要な記述
  acts_as_taggable

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
