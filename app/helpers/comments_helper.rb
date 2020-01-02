module CommentsHelper
  def comment_height(cnt)
    cnt.to_i.zero? ? 100 : 300
  end
end
