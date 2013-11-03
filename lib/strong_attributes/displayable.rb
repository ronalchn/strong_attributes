module StrongAttributes
  module Displayable
    extend ActiveSupport::Concern
    include StrongAttributes::Permissible

    # Displays the result of each method call if permitted. To permit all without checking, call `permit!` first.
    #
    # Calls and returns the result of each method call in the argument list. If a block is given, then each result
    # is passed to the block.
    #
    #   user.presents :username, :email # returns [user.username, user.email]
    #
    # Or with two arguments, the name of the field is passed first:
    #
    #   <ul>
    #     <% user.presents :username, :email, :address do |field, value| %>
    #       <li><%= field.capitalize %>: <% value %></li>     
    #     <% end %>
    #   </ul>
    #
    # If only the presented value is desired, use `each`:
    #
    #   <% user.presents(:username, :email).each do |value| %>
    #     <td><%= value %></td>
    #   <% end %>
    #
    # Arguments can be included in an array:
    #
    #   user.presents :username, [:notifications, :unread] # returns [user.username, user.notifications(:unread)]
    #
    def presents *attributes
      select_permitted(*attributes).map do |attribute_path|
        value = Array(attribute_path).inject(self) { |obj, args| obj.public_send *args }
        yield attribute_path, value if block_given?
        value
      end
    end

    # Same as presents, but for a single attribute. The differences are:
    #   - the return value is not in an Array
    #   - passes the value only (without attribute key as the 1st argument) to a block
    def present field
      presents field do |key, value|
        yield value if block_given?
      end.first
    end
  end
end
