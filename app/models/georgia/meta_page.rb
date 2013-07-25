module Georgia
  class MetaPage < Georgia::Page

    validates :slug, uniqueness: {scope: :ancestry, message: 'has already been taken'}

  end
end