# frozen_string_literal: true

unless Cohort.first
  Cohort.create!(start_year: 2021)
  Cohort.create!(start_year: 2022)
end

unless Rails.env.production?
  if AdminProfile.none?
    user = User.find_or_create_by!(email: "admin@example.com") do |u|
      u.full_name = "Admin User"
    end
    AdminProfile.find_or_create_by!(user: user)
  end

  if InductionCoordinatorProfile.none?
    user = User.find_or_create_by!(email: "school-leader@example.com") do |u|
      u.full_name = "School Leader User"
    end
    InductionCoordinatorProfile.find_or_create_by!(user: user)
  end

  if MentorProfile.none?
    user = User.find_or_create_by!(email: "mentor@example.com") do |u|
      u.full_name = "Mentor User"
    end
    MentorProfile.find_or_create_by!(user: user)
  end

  CoreInductionProgramme.all.each do |cip|
    cip_name_for_email = cip.name.gsub(/\s+/, "-").downcase

    user = User.find_or_create_by!(email: "#{cip_name_for_email}-early-career-teacher@example.com") do |u|
      u.full_name = "#{cip.name} ECT User"
    end
    EarlyCareerTeacherProfile.find_or_create_by!(user: user, cohort: Cohort.first, core_induction_programme: cip, mentor_profile: MentorProfile.first)
  end
end
