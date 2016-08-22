module PostsHelper
  def other_likes(likeable)

    likes = likeable.likes
    likers = likes.map { |like| like.liker }
    return if likes.length < 1
    if likes.length == 1
      if likers.first == current_user
        "You liked this"
      else
        "#{likes.first.liker.full_name} liked this"
      end

    elsif likes.length == 2
      if likers.any? { |u| u == current_user }
        likers.delete(current_user)
        "You and #{likers.first.full_name} liked this"
      else
        "#{likers.first.full_name} and #{likers.second.full_name} liked this"
      end

    else
      "#{likers.first.full_name} and #{likers.second.full_name} and #{likes.count - 2} others liked this"

    end
  end


  def current_page_user_id


    if params[:user_id]
        return params[:user_id].to_i
    elsif params[:controller] ==  "photos" && params[:action] == "show"
      return Photo.find(params[:id]).user_id
    else
      return params[:id].to_i
    end
  end

end
