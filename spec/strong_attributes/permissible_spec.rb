require 'spec_helper'

module StrongAttributes
  describe Permissible do
    it "selects permitted attributes" do
      permissible = Object.new
      permissible.extend(Permissible)
      
      permissible.permit! :a, :b, :c
      permitted = permissible.select_permitted :a, :c, :z
      expect(permitted).to include(:a, :c)
      expect(permitted).to_not include(:b, :z)
    end

    it "permits all if permit_all!" do
      permissible = Object.new
      permissible.extend(Permissible)

      permissible.permit_all!
      permitted = permissible.select_permitted :a, :b, :c
      expect(permitted).to include(:a, :b, :c)
    end
  end
end
