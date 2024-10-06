class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end

# def follow_user
#  @follower = current_user
#  @followed = User.find(params[:id])
#  @relation = Relationship.new(follower_id:@follower.id,followed_id:@followed.id)
#  @relation.save
# end

# def follow_user
#   @user = User.find(params[:id])
#   current_user.followings.build(followed_id:@user.id)
# end
