class UsersController < ApplicationController
    def index
       @fruits = Fruit.all
       render json: {
           message: 'Halo',
           data: fruits
       }
    end
end
