require 'rails_helper'

RSpec.describe "Api::V1::Categories", type: :request do
  describe 'GET /index' do
    before do
      FactoryBot.create_list(:category, 1)
      get "/api/v1/categories"
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
            name: "category name",
            description: "category description"
          }
        }
      end

      it 'returns the name' do
        expect(json['name']).to eq("category name")
      end

      it 'returns the description' do
        expect(json['description']).to eq("category description")
      end

      it 'return a created status' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      before do
        post "/api/v1/categories", params: {
          category: {
            name: '',
            description: ''
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
      let!(:category_var) { FactoryBot.create(:category) }

      before do
        put "/api/v1/categories/#{category_var.id}", params: {
          category: {
            name: "new name category",
            description: "new description category"
          }
        }
      end

      it 'return the updated name' do
        expect(json['name']).to eq("new name category")
      end

      it 'return the updated description' do
        expect(json['description']).to eq("new description category")
      end
  
      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'with invalid parameters' do
      let!(:category_var) { FactoryBot.create(:category) }
      
      before do
        put "/api/v1/categories/#{category_var.id}", params: {
          category: {
            name: "",
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
    let!(:category_var) { FactoryBot.create(:category) }

    before do
      delete "/api/v1/categories/#{category_var.id}"
    end

    it 'return status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
