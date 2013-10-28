module Georgia
  module CheckboxesHelper

    def checkboxable_tag name
      check_box_tag(name, nil, nil, data: {checkbox: 'child', state: 'uncheck'})
    end

    def checkboxable_all_tag name
      check_box_tag(name, nil, false, data: {checkbox: 'all', state: 'uncheck'})
    end

  end
end