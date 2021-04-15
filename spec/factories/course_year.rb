# frozen_string_literal: true

FactoryBot.define do
  factory :course_year do
    title { "Test Course year" }
    content { "No content" }

    trait :with_cip do
      core_induction_programme_one { FactoryBot.create(:core_induction_programme) }
    end
  end
end
