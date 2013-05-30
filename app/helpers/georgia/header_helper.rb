module Georgia
  module HeaderHelper

    def render_extra_header_partials
      return unless Georgia.header.any?
      Georgia.header.map{|partial| render(partial: "georgia/header/#{partial}") }.join('').html_safe
    end

  end
end