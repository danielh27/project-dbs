module UserHelper
  def fullname(user)
    "#{user.first_name} #{user.last_name}"
  end
end
