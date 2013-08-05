module Georgia
  class MetaPage < Georgia::Page

    include Georgia::Concerns::Copyable

    validates :slug, uniqueness: {scope: :ancestry, message: 'has already been taken'}

    def to_param
      self.uuid
    end

  end
end