# frozen_string_literal: true

year = FactoryBot.create(:course_year)
course_module = FactoryBot.create(:course_module, course_year: year)
FactoryBot.create(:course_lesson, :with_lesson_part, course_module: course_module)

# You have to create this user in your spec before running this scenario
cip = User.find("53960d7f-1308-4de1-a56d-de03ea8e1d9c").core_induction_programme

CoreInductionProgramme.find(cip.id).update!(course_year_one_id: year.id)
