# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :remember_token
  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :introduce, length: { maximum: 100 }
  mount_uploader :picture, ImagesUploader
  validate :picture_size

  # お気に入り
  has_many :likes, dependent: :destroy
  has_many :likebooks, through: :likes, source: :book
  # # コメント
  has_many :comments

  # お気に入り追加
  def like(book)
    likebooks << book
  end

  # お気に入り削除
  def notlike(book)
    like = likes.find_by(book_id: book.id)
    like.destroy
  end

  # お気に入り登録判定
  def likebook?(book)
    likebooks.include?(book)
  end

  def self.digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # 永続ログインの解除
  def forget
    update_attribute(:remember_digest, nil)
  end

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  # # 必要な投稿を取得
  def feed
    Micropost.where("user_id IN (:following_ids)
     OR user_id     =   :user_id",
                    following_ids: following_ids, user_id: id).includes([:user])
  end

  private

  # アップロード画像のサイズを検証する
  def picture_size
    errors.add(:image, 'should be less than 5MB') if picture.size > 5.megabytes
  end
end
