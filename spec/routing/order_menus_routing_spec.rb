require "rails_helper"

RSpec.describe OrderMenusController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/order_menus").to route_to("order_menus#index")
    end

    it "routes to #show" do
      expect(get: "/order_menus/1").to route_to("order_menus#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/order_menus").to route_to("order_menus#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/order_menus/1").to route_to("order_menus#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/order_menus/1").to route_to("order_menus#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/order_menus/1").to route_to("order_menus#destroy", id: "1")
    end
  end
end
