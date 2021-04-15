# frozen_string_literal: true

require "devise/strategies/authenticatable"

module Devise
  module Strategies
    class YoloAuthenticatable < Authenticatable
      def authenticate!
        if params[:user].present?
          user = User.find_or_initialize_by(email: params[:user][:email])

          unless user.persisted?
            user.errors.add :email, "Enter the email address your school used when they created your account"
          end
          success! user
        end
      end
    end
  end
end

Warden::Strategies.add(:yolo_authenticatable, Devise::Strategies::YoloAuthenticatable)
