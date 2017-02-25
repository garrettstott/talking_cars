namespace :populate do
  desc "Creates Users, Makes, Models, Forums, Posts and Replies for Development"
  task development: :environment do
    puts "**************************************"
    puts "SEEDING"
    puts "**************************************"

    puts "Creating Users"

    users = [ {username: 'garrettstott', email: 'garrettstott@gmail.com', password: 'password'},
              {username: 'joe', email: 'joe@example.com', password: 'password'}
            ]

    users.each do |user|
      user = User.new(username: user[:username], email: user[:email], password: user[:password])
      if user.save
        puts "Created User #{user.username}"
      else
        puts "Error creating User #{user.username} #{user.errors.full_messages}"
      end
    end

    makes = %w(Subaru)
    models = %w(BRZ)

    puts "Creating Makes..."

    makes.each do |make_i|
      make = Make.new(name: make_i)
      if make.save
        puts "Created Make #{make.name}"
        puts "Creating Modles for #{make.name}"
        models.each do |model|
          model = Model.new(name: model, make_id: make.id)
          if model.save
            puts "Created Model #{model.name}"
          else
            puts "Error creating Model #{model.name} #{model.errors.full_messages}"
          end
        end
      else
        puts "Error creating Make #{make.name} #{make.errors.full_messages}"
      end
    end


    forums = [ {name: 'Test Forum General 1', description: 'This is the description', category: 'General'},
               {name: 'Test Forum General 2', description: 'This is the description', category: 'General'},
               {name: 'Test Forum General 3', description: 'This is the description', category: 'General'},
               {name: 'Test Forum Technical 1', description: 'This is the description', category: 'Technical'},
               {name: 'Test Forum Technical 2', description: 'This is the description', category: 'Technical'},
               {name: 'Test Forum Technical 3', description: 'This is the description', category: 'Technical'},
               {name: 'Test Forum Classified 1', description: 'This is the description', category: 'Classified'},
               {name: 'Test Forum Classified 2', description: 'This is the description', category: 'Classified'},
               {name: 'Test Forum Classified 3', description: 'This is the description', category: 'Classified'}
             ]

    posts = [ {subject: 'Test subject 1', body: 'This is test subject 1 body'},
              {subject: 'Test subject 2', body: 'This is test subject 2 body'},
              {subject: 'Test subject 3', body: 'This is test subject 3 body'}
            ]

    replies = [ { body: 'This is testing a reply 1' },
                { body: 'This is testing a reply 2' }
              ]

    users = User.all
    models = Model.all

    puts "Creating Forums..."

    models.each do |model|
      forums.each do |forum|
        forum = Forum.new(name: forum[:name], description: forum[:description], category: forum[:category], model_id: model.id)
        if forum.save
          puts "Created Forum #{forum.name}"
          puts "Creating Posts..."
          users.each do |user|
            posts.each do |post|
              new_post = Post.new(subject: post[:subject], body: post[:body], user_id: user.id, forum_id: forum.id)
              if new_post.save
                puts "Created Post #{new_post.subject}"
                puts "Creating Replies..."
                users.each do |user|
                  replies.each do |reply|
                    new_reply = Reply.new(user_id: user.id, post_id: new_post.id, body: reply[:body])
                    if new_reply.save
                      puts "Created Reply from #{user.username}"
                    else
                      puts "Error creating Reply #{user.username} #{new_reply.body} #{new_pust.errors.full_messages}"
                    end
                  end
                end
              else
                puts "Error creating Post #{new_post.subject} #{new_post.errors.full_messages}"
              end
            end
          end
        else
          puts "Error creating Forum #{forum.name} #{forum.errors.full_messages}"
        end
      end
    end

    puts "**************************************"
    puts "DONE!"
    puts "**************************************"
  end

  desc "Creates Makes, Models, Forums for Production"
  task production: :environment do
    # puts "Edmunds API"
    #
    # edmunds = HTTParty.get('http://api.edmunds.com/api/vehicle/v2/makes?fmt=json&api_key=jstqruuvgg5bhzrk9v393svu')
    # makes = edmunds['makes']
    #
    # makes.each do |make_i|
    #   make = Make.new(name: make_i['name'].gsub(/-/, ' ').titleize)
    #   if make.save
    # puts "Created Make #{make.name}"
    # puts "Creating Modles for #{make.name}"
    # models = make_i['models']
    # models.each do |model|
    # model = Model.new(name: model['name'], make_id: make.id)
    # if model.save
    # puts "Created Model #{model.name}"
    # else
    # puts "Error creating Model #{model.name} #{model.errors.full_messages}"
    # end
    # end
    # else
    # puts "Error creating Make #{make.name} #{make.errors.full_messages}"
    # end
    # end
    # end

  end

end
