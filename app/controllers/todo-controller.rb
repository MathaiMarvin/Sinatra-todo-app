class TodoController < Sinatra::Base
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

    put '/todos/update/:id' do
        # using the hash
    end
end