require 'rails_helper'

RSpec.describe "Api::V1::Menus", type: :request do
  describe 'GET /index' do
    before do
      FactoryBot.create_list(:category, 1)

      FactoryBot.create_list(:menu, 1)

      get "/api/v1/menus"
    end
    
    it 'returns all posts' do
      expect(json.size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      before do
        post "/api/v1/categories", params: {
          category: {
            name: "Local",
            description: "Local description"
          }
        }
  
        post "/api/v1/menus", params: {
          menu: {
            name: "Bubur",
            price: 1.5,
            description: "So Yummy"
          },
          category: {
            category_name: "Local"
          }
        }
      end

      it 'return a created status' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      before do
        post "/api/v1/categories", params: {
          category: {
            name: "Local",
            description: "Local description"
          }
        }
  
        post "/api/v1/menus", params: {
          menu: {
            name: "",
            price: 1.5,
            description: ""
          },
          category: {
            category_name: "Local"
          }
        }
      end

      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT /update" do
    context 'with valid parameters' do
      let!(:menu_var) { 
        FactoryBot.create(:category)
        FactoryBot.create(:menu)
      }

      before do
        put "/api/v1/menus/#{menu_var.id}", params: {
          menu: {
            name: "new food name",
            price: 1.0,
            description: "new food description"
          }
        }
      end
  
      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'with invalid parameters' do
      let!(:menu_var) { 
        FactoryBot.create(:category)
        FactoryBot.create(:menu)
      }
      
      before do
        put "/api/v1/menus/#{menu_var.id}", params: {
          menu: {
            name: "",
            price: 1.0,
            description: ""
          }
        }
      end

      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:menu_var) { 
      FactoryBot.create(:category)
      FactoryBot.create(:menu)
    }

    before do
      delete "/api/v1/menus/#{menu_var.id}"
    end

    it 'return status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
