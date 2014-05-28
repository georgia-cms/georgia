module Georgia
  module CheckboxesHelper

    def checkboxable_tag checkboxable
      check_box_tag(dom_id(checkboxable), nil, nil, data: {checkbox: 'child', state: 'unchecked', id: checkboxable.id})
    end

    def checkboxable_all_tag name
      check_box_tag(name, nil, false, data: {checkbox: 'all', state: 'unchecked'})
    end

  end
end