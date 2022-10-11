class Micropost < ApplicationRecord
  belongs_to :user ,dependent: :destroy  #khi destroy user thi many post of user cung bi xoa
  has_one_attached :image  #image collum
  default_scope -> {order(created_at: :desc)}  #sap xem thoi gian tao record theo giam dan``
  validates :user_id, presence:true
  validates :content, presence: true, length: { maximum: 140 ,minimum: 4}
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],   
    message: "must be a valid image format" },
    size: { less_than: 5.megabytes,  #image nho hon 5mb
    message: "should be less than 5MB" }  #validate image before post


    #return resize image
    def display_image
      image.variant(resize_to_limit: [500,500])
    end
end
# user.microposts.create
# user.microposts.create!
# user.microposts.build

# su dung nhu nay thi user_id tu dong duoc tao trung voi user tao