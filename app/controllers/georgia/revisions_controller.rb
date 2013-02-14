module Georgia
  class RevisionsController < Georgia::ApplicationController

    def revert
      @revision = ActsAsRevisionable::RevisionRecord.find(params[:id])
      if @revision.restore.save
        redirect_to :back, notice: "Successfully reverted to the selected revision"
      else
        redirect_to :back, notice: "Oups. Something went wrong."
      end
    end

  end
end