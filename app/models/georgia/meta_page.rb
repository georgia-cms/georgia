module Georgia
  class MetaPage < Georgia::Page

    include Georgia::Concerns::Indexable

    validates :slug, uniqueness: {scope: :ancestry, message: 'has already been taken'}

    def to_param
      uuid
    end

    class << self

      def find(id)
        @publisher = Georgia::Publisher.new(id)
        @page = @publisher.meta_page
      end

    end

  end
end