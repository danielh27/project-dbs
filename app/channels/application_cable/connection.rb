module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # identified_by :current_user

    # def connect
    #   self.current_user = find_verified_user
    # end

    # protected

    # def find_verified_user
    #   # if (current_user = env['warden'].user)
    #   #   return current_user
    #   # else
    #   #   return nil
    #   # end
    #   debugger
    #    if verified_user = User.find_by(id: cookies.encrypted[:user_id])
    #       verified_user
    #     else
    #       reject_unauthorized_connection
    #     end
    # end
  end
end
