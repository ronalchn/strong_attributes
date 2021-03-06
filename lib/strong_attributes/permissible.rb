module StrongAttributes
  module Permissible
    extend ActiveSupport::Concern

    # Permits given attributes. May be invoked multiple times.
    #
    # @example Each argument represents a single attribute:
    #   ArticlePresenter.new(@article).permit(:heading, :article)
    #
    # @example Attribute paths can be specified using symbol arrays. If an author name is normally accessed using @article.author.name:
    #   ArticlePresenter.new(@article).permit([:author, :name])
    #
    # @param [[Symbols*]*] attribute_paths
    #   the attributes to permit. An array of symbols represents an attribute path.
    # @return [self]
    def permit! *attribute_paths
      permitted_attributes.permit *attribute_paths
      self
    end

    # Permits all presenter attributes for presents, present & filter methods.
    def permit_all!
      permitted_attributes.permit_all!
      self
    end

    # Selects the attributes given which have been permitted - an array of attributes
    # @param [Array<Symbols>*] attribute_paths
    #   the attribute paths to check. The attribute paths may also have arguments.
    # @return [Array<Array<Symbol>>] attribute (paths)
    def select_permitted *attribute_paths
      permitted_attributes.select_permitted *attribute_paths
    end

    protected
    def permitted_attributes
      @permitted_attributes ||= StrongAttributes::Permissions.new
    end

    # Links permissions to that of the parent.
    # @param [Permissible] parent
    # @param [Array<Symbol>] relative_path
    #   The prefix prepended before every permission check relative to parent.
    def link_permissions parent, relative_path = []
      @permitted_attributes = StrongAttributes::Permissions.new(parent.permitted_attributes, relative_path)
    end

  end
end

