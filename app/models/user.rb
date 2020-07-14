class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  attachment :profile_image, destroy: false

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}

  # フォロー機能

  # フォロー取得(ユーザーとフォローする人を結びつける)
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # フォロワー取得(ユーザーとフォローされる人を結びつける)
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  # 自分がフォローしているユーザーと自分をフォローしているユーザーを簡単に取得するためにthroughを使った関連付けを追記
  # 自分がフォローしている人
  has_many :following_user, through: :follower, source: :followed
  # 自分をフォローしている人
  has_many :follower_user, through: :followed, source: :follower

# ユーザーをフォローする
def follow(user_id)
  follower.create(followed_id: user_id)
end
# ユーザーのフォローを外す
def unfollow(user_id)
  follower.find_by(followed_id: user_id).destroy
end
# フォローしていればtrueを返す
def following?(user)
  following_user.include?(user)
end
end
