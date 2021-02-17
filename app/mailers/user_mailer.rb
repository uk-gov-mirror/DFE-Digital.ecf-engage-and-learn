# frozen_string_literal: true

class UserMailer < ApplicationMailer
  SIGN_IN_EMAIL_TEMPLATE = "7ab8db5b-9842-4bc3-8dbb-f590a3198d9e"
  ECT_WELCOME_TEMPLATE = "147031f0-cd41-483c-a679-13bc3fd0d4f5"
  MENTOR_WELCOME_TEMPLATE = "252333c2-1785-45cf-bd11-24dc61fd8c49"

  def sign_in_email(user, url)
    template_mail(
      SIGN_IN_EMAIL_TEMPLATE,
      to: user.email,
      rails_mailer: mailer_name,
      rails_mail_template: action_name,
      personalisation: {
        full_name: user.full_name,
        sign_in_url: url,
      },
    )
  end

  def early_career_teacher_welcome(user, url)
    template_mail(
      ECT_WELCOME_TEMPLATE,
      to: user.email,
      rails_mailer: mailer_name,
      rails_mail_template: action_name,
      personalisation: {
        full_name: user.full_name,
        sign_in_url: url,
      },
    )
  end

  def mentor_welcome(user, url)
    template_mail(
      MENTOR_WELCOME_TEMPLATE,
      to: user.email,
      rails_mailer: mailer_name,
      rails_mail_template: action_name,
      personalisation: {
        full_name: user.full_name,
        sign_in_url: url,
      },
    )
  end
end
