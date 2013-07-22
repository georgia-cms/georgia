module Georgia
  class MetaPage < Georgia::Page
    
    include Georgia::Concerns::Revisionable

    validates :slug, uniqueness: {scope: :ancestry, message: 'has already been taken'}

    end
end