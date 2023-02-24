class TodoController < Sinatra::Base

    set :views, './app/views'

    # before do
    #     puts "hello, to this route"
    # end

    get'/' do
        "Welcome to TodoController"
    end

    post '/todos/create' do
        # Data formatted as jsin
        data = JSON.parse(request.body.read)

        # Setting up a rescue blick to catch errors
        begin
            
            #code

             #Create a record on the table
                #Approach one use individual columns
                today = Time.now
                # title = data["title"]
                # description = data["description"]

                # todo = Todo.create(title: title, description:description, createdAt:today)
                # todo.to_json


                #Approach 2 using hash of columns
                data["createdAt"] = today
                todo = Todo.create(data)
                [201, todo.to_json]

                #Approach 3 using hash of columns
            rescue => e

               [422, {
                    error: "Error occured"
            }.to_json]

        end

       
    end

    get '/todos' do 

        todos = Todo.all
        [200, todos.to_json]

    end
    get '/view/todos' do
        @todos = Todo.all
        erb :todos
    end

    put '/todos/update/:id' do

        begin
        # using the hash

            data = JSON.parse(request.body.read)
            todo_id = params['id'].to_i
            todo = Todo.find(todo_id)
            todo.update(data)
            {message: "TODO UPDATED"}.to_json

        rescue => e

            [422, {error: e.message}.to_json]

        end
    end
    delete '/todos/destroy/:id' do
            begin
                todo_id = params['id'].to_i
                todo = Todo.find(todo_id)
                todo.destroy
                {message: "Successfully deleted"}.to_json

            rescue => e

                    [422, {error: e.message}.to_json]

            end
    end
        
    
end