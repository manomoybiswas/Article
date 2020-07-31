module ApplicationHelper
  def category_count
    Category.count
  end
  def user_count
    User.count
  end
  def post_count
    current_user.post.count
  end
  def comment_count
    current_user.comments.count
  end
end
