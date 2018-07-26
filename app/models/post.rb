class Post < ApplicationRecord
	validates :content, {presence: true, length: {maximum: 140}}
	validates :user_id, {presence: true}

	# 投稿に紐づいたuserインスタンスを戻り値として返す
	def user
		return User.find_by(id: self.user_id)
	end

	# 投稿時間の表示
  	def post_time(time)
    	time.strftime('%Y/%m/%d %H:%M')
	end
end
