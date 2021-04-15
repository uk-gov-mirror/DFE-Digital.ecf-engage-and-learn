# frozen_string_literal: true

FactoryBot.define do
  factory :course_module do
    title { "Test Course module" }
    content { "No content" }
    course_year { FactoryBot.create(:course_year) }

    trait :with_previous do
      after :build do |course_module|
        course_module.previous_module = FactoryBot.create(:course_module, course_year: course_module.course_year, title: "Test previous module")
      end
    end
  end
end
