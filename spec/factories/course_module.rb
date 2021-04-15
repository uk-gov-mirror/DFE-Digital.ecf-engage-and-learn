# frozen_string_literal: true

FactoryBot.define do
  factory :course_module do
    year = CourseYear.new(title: "Test Course year", content: "No content", core_induction_programme_one: FactoryBot.create(:core_induction_programme))

    title { "Test Course module" }
    content { "No content" }
    course_year { year }

    trait :with_previous do
      previous_module do
        FactoryBot.create(:course_module, course_year: year, title: "Test previous module")
      end
    end
  end
end
