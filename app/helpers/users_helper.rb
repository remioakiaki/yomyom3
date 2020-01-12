# frozen_string_literal: true

module UsersHelper
  def admin?
    current_user.admin?
  end
end
