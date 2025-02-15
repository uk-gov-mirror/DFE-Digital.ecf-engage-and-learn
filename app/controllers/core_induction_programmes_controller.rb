# frozen_string_literal: true

class CoreInductionProgrammesController < ApplicationController
  include Pundit
  include CipBreadcrumbHelper

  before_action :authenticate_user!

  def index
    authorize CoreInductionProgramme
    @core_induction_programmes = CoreInductionProgramme.all
  end

  def show
    @core_induction_programme = CoreInductionProgramme.find(params[:id])
    authorize @core_induction_programme
  end

  def download_export
    if current_user&.admin?
      CoreInductionProgrammeExporter.new.run

      send_file(
        Rails.root.join("db/seeds/cip_seed_dump.rb"),
        filename: "cip_seed_dump.rb",
        type: "text/plain",
      )
    else
      redirect_to cip_index_path
    end
  end
end
