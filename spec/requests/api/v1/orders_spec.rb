require 'rails_helper'

RSpec.describe "Api::V1::Orders", type: :request do
  describe "GET /index" do
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

      post "/api/v1/orders", params: {
        order: {
          customer_name: "Test",
          customer_email: "test@gigih.com"
        },
        menu: {
          menu_name: "Bubur",
          quantity: 3
        }
      }

      get "/api/v1/orders"
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

        post "/api/v1/orders", params: {
          order: {
            customer_name: "Test",
            customer_email: "test@gigih.com"
          },
          menu: {
            menu_name: "Bubur",
            quantity: 3
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
            name: "Bubur",
            price: 1.5,
            description: " So Yummy"
          },
          category: {
            category_name: "Local"
          }
        }

        post "/api/v1/orders", params: {
          order: {
            customer_name: "",
            customer_email: ""
          },
          menu: {
            menu_name: "Bubur",
            quantity: 3
          }
        }
      end

      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /update' do
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

        post "/api/v1/orders", params: {
          order: {
            customer_name: "Test",
            customer_email: "test@gigih.com"
          },
          menu: {
            menu_name: "Bubur",
            quantity: 3
          }
        }

        put "/api/v1/orders/1", params: {
          order: {
            customer_name: "Change",
            customer_email: "changetest@gigih.com"
          },
          menu: {
            menu_name: "Bubur",
            quantity: 3
          }
        }
      end

      it 'return status code 200' do
        expect(response).to have_http_status(200)
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
            name: "Bubur",
            price: 1.5,
            description: " So Yummy"
          },
          category: {
            category_name: "Local"
          }
        }

        post "/api/v1/orders", params: {
          order: {
            customer_name: "",
            customer_email: ""
          },
          menu: {
            menu_name: "Bubur",
            quantity: 3
          }
        }
      end

      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:order_var) { 
      FactoryBot.create(:category)
      FactoryBot.create(:menu)
      FactoryBot.create(:order)
    }

    before do
      delete "/api/v1/orders/#{order_var.id}"
    end

    it 'return status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
