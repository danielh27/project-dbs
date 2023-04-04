module UserHelper
  def fullname(user)
    user.business_name.to_s
  end
end
