module Georgia
  class MetaPage < Georgia::Page

    validates :slug, uniqueness: {scope: :ancestry, message: 'has already been taken'}

    def to_param
      self.uuid
    end

    class << self

      def find(uuid)
        @publisher = Georgia::Publisher.new(uuid)
        @page = @publisher.meta_page
      end

    end

  end
end