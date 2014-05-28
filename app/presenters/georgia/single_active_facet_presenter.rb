module Georgia
  class SingleActiveFacetPresenter < ActiveFacetPresenter

    private

    def unmerged_params
      params.except(param)
    end
  end
end