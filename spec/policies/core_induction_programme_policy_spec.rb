# frozen_string_literal: true

require "rails_helper"

RSpec.describe CoreInductionProgrammePolicy, type: :policy do
  subject { described_class.new(user, core_induction_programme) }
  let(:core_induction_programme) { create(:core_induction_programme) }

  context "accessing show as early career teacher" do
    let(:user) { create(:user, :early_career_teacher, { core_induction_programme: core_induction_programme }) }

    it { is_expected.to permit_action(:show) }
  end
end
