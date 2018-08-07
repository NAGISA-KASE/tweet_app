class User < ApplicationRecord
	has_secure_password
	mount_uploader :avatar, AvatarUploader

	validates :name, {presence: true, length: {maximum: 16}}
	validates :email, {presence: true, uniqueness: true}
	validates :account_name, {presence: true, uniqueness: true, length: {maximum: 14}, format: { with: /\A[a-z0-9]+\z/i }}
	validates :introduction, {length: {maximum: 160}}

	# ユーザーに紐づく投稿をまとめて取得
	def posts
		return Post.where(user_id: self.id)
	end

end
