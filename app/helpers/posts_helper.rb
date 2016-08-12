module PostsHelper
  def other_likes(likeable)
    likes = likeable.likes
    users = likes.map { |like| like.liker }
    return if likes.length < 1
    if likes.length == 1
      if users.first == current_user
        "You liked this"
      else
        "#{user.full_name} liked this"
      end
    # elsif likes.length == 2
    #   if users.any? { |u| u == current_user }
    #     users.delete(current_user)
    #     "You and #{users.first.full_name} liked this"
    #   else
    #     "#{users.first.full_name} and #{users.second.full_name} liked this"
    #   end
    else
      "#{users.first.full_name} and #{users.second.full_name} and #{likes.count - 2} others liked this"

    end
  end

end
