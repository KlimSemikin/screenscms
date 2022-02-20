class PrivateController < ApplicationController
  include Secured

  def current_user
    return unless @auth_payload
    sub = @auth_payload['sub']
    @current_user ||= User.find_or_create_by(auth0_uid: sub)
  end
end
