module Georgia
  class MetaPage < Georgia::Page

    include Georgia::Concerns::Copyable

    validates :slug, uniqueness: {scope: :ancestry, message: 'has already been taken'}

    def to_param
      self.uuid
    end

    def draftable?
      true
    end

    def publishable?
      true
    end

    class << self

      def find(uuid, args={})
        @publisher = Georgia::Publisher.new(uuid)
        @page = @publisher.meta_page
      end

    end

  end
end