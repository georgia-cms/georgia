module Georgia
  class Draft < Georgia::Page

    include Georgia::Concerns::Clonable

    def reviewable?
      true
    end

  end
end