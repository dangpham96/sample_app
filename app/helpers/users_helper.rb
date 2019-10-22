module UsersHelper
  def gravatar_for user, size: Settings.webpage_user.user_size_img
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    gravatar_url = "#{Settings.webpage.gravatar_user}/#{gravatar_id}?s=#{size}"
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end

  def find_relationship user_id
    current_user.active_relationships.find_by followed_id: user_id
  end

  def build_relationship
    current_user.active_relationships.build
  end
end
