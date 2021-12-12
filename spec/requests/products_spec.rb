require 'rails_helper'

RSpec.describe "Products", type: :request do
  let!(:products) { create_list(:product, 20) }
  let(:product) { create(:product) }

  describe 'All list products' do # Judul test case nya
    context 'when get all products' do # Sub judul test case nya
      it 'return 200 get list products' do # Test case
        get '/products'

        response_body = JSON.parse(response.body)
        response_data = response_body["data"]
        expect(response_body["data"].length).to eq(10)

        response_data.each do |val|
          expect(val["id"]).to be_an(Integer)
        end
      end

      it 'return only 10 record with page' do
        get '/products', params: {page: 1, per_page: 10}

        response_body = JSON.parse(response.body)
        response_data = response_body['data']

        expect(response_body['data'].length).to eq(10)

        response_data.each do |val|
          expect(val["id"]).to be_an(Integer)
        end
      end
    end
  end

  describe 'Show product by id' do
    context 'when show product by id' do
      it 'return 200 using valid id' do 
        get "/products/#{product.id}"

        response_body = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(response_body["id"]).to eq(product.id)
        expect(response_body["name"]).to eq(product.name)
      end

      it 'return 404 using invalid id' do
        get "/products/#{rand(9000..100000)}"

        response_body = JSON.parse(response.body)

        expect(response.status).to eq(404)
        expect(response_body["message"]).to be_an(String)
      end
    end
  end

  describe 'Create product' do
    context 'when create product' do
      it 'return 201 using valid param body' do
        post '/products', params: {
          name: 'Indomilk',
          price: 250000,
          category: 'Susu segar'
        }

        expect(response.status).to eq(201)
      end

      it 'return 400 using invalid params', :skip do
        post '/products', params: {}

        p response.body

        expect(response.status).to eq(400)
      end
    end
  end

  describe 'Update product' do
    context 'when update product' do
      it 'return 200 using valid id and body' do
        put "/products/#{product.id}", params: {
          name: 'Susu nasional',
          price: 10000,
          category: "Susu"
        }

        expect(response.status).to eq(200)
      end

      it 'return 404 using invalid id' do
      end

      it 'return 400 using invalid body' do
      end
    end
  end

  describe 'Delete product by id' do
    context 'when delete product by id' do
      it 'return 200 using valid id' do
        delete "/products/#{product.id}"

        expect(response.status).to eq(200)
      end

      it 'return 404 using invalid id' do
      end
    end
  end
end
