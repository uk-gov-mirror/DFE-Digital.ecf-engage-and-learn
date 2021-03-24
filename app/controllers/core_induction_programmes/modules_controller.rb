# frozen_string_literal: true

class CoreInductionProgrammes::ModulesController < ApplicationController
  include Pundit
  include GovspeakHelper
  include CipBreadcrumbHelper

  after_action :verify_authorized
  before_action :authenticate_user!, except: :show
  before_action :load_course_module, except: %i[new create]

  def show; end

  def new
    authorize CourseModule
    @course_module = CourseModule.new
    @course_years = CourseYear.where(core_induction_programme_id: params[:cip_id])
  end

  def create
    authorize CourseModule
    @course_module = CourseModule.new(
      course_module_params.merge(course_year: find_course_year, previous_module: find_previous_module.last),
    )

    if @course_module.valid?
      @course_module.save!
      redirect_to cip_index_path
    else
      @course_years = CourseYear.all
      render action: "new"
    end
  end

  def edit; end

  def update
    @course_module.assign_attributes(course_module_params)
    if params[:commit] == "Save changes"
      @course_module.save!
      flash[:success] = "Your changes have been saved"
      redirect_to year_module_url
    else
      render action: "edit"
    end
  end

private

  def load_course_module
    @course_module = CourseModule.find(params[:id])
    authorize @course_module
    @course_lessons_with_progress = @course_module.lessons_with_progress @current_user
  end

  def course_module_params
    params.require(:course_module).permit(:content, :title, :term, :course_year_id)
  end

  def find_course_year
    CourseYear.find_by(id: params[:course_module][:course_year])
  end

  def find_previous_module
    CourseModule.where(course_year_id: find_course_year)
  end
end
