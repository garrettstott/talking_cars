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

    posts = [ {subject: 'Test subject 1', body: 'This is test subject 1 body. This is going to be long so I can see if there is going to be an issue with long ass bodys on posts. This is test subject 1 body. This is going to be long so I can see if there is going to be an issue with long ass bodys on posts. This is test subject 1 body. This is going to be long so I can see if there is going to be an issue with long ass bodys on posts.'},
              {subject: 'Test subject 2', body: 'This is test subject 2 body. This is going to be long so I can see if there is going to be an issue with long ass bodys on posts. This is test subject 1 body. This is going to be long so I can see if there is going to be an issue with long ass bodys on posts. This is test subject 1 body. This is going to be long so I can see if there is going to be an issue with long ass bodys on posts.'},
              {subject: 'Test subject 3', body: 'This is test subject 3 body. This is going to be long so I can see if there is going to be an issue with long ass bodys on posts. This is test subject 1 body. This is going to be long so I can see if there is going to be an issue with long ass bodys on posts. This is test subject 1 body. This is going to be long so I can see if there is going to be an issue with long ass bodys on posts.'}
            ]

    replies = [ { body: 'This is test subject 1 body. This is going to be long so I can see if there is going to be an issue with long ass bodys on replies. This is test subject 1 body. This is going to be long so I can see if there is going to be an issue with long ass bodys on replies. This is test subject 1 body. This is going to be long so I can see if there is going to be an issue with long ass bodys on replies.' },
                { body: 'This is test subject 1 body. This is going to be long so I can see if there is going to be an issue with long ass bodys on replies. This is test subject 1 body. This is going to be long so I can see if there is going to be an issue with long ass bodys on replies. This is test subject 1 body. This is going to be long so I can see if there is going to be an issue with long ass bodys on posts.' }
              ]

    users = User.all
    models = Model.all

    puts "Creating Forums..."

    models.each do |model|
      forums = set_forums(model)
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
    puts "**************************************"
    puts "SEEDING"
    puts "**************************************"

    begin
      puts "Edmunds API"
      edmunds = HTTParty.get("http://api.edmunds.com/api/vehicle/v2/makes?fmt=json&api_key=#{ENV['EDMUNDS_KEY']}")
    rescue Execption => e
      puts edmunds
      puts e.message
      puts e.backtrace.inspect
    end
    if edmunds['makes']
      makes = edmunds['makes']
    else
      puts edmunds
    end

    if makes
      makes.each do |make_i|
        make = Make.new(name: make_i['name'].gsub(/-/, ' ').titleize)
        if make.save
          models = make_i['models']
          models.each do |model|
            model = Model.new(name: model['name'], make_id: make.id)
            if model.save
              forums = set_forums(model)
              forums.each do |forum|
                forum = Forum.new(name: forum[:name], description: forum[:description], category: forum[:category], model_id: model.id)
                if forum.save
                  puts "Created Forum #{forum.name}"
                else
                  puts "Error creating Forum #{forum.name} #{forum.errors.full_messages}"
                end
              end
            else
              puts "Error creating Model #{model.name} #{model.errors.full_messages}"
            end
          end
        else
          puts "Error creating Make #{make.name} #{make.errors.full_messages}"
        end
      end
    end
  end
end


#     Forum.create(name: 'General Community', description: "The General Forum on Talking Cars is for general discussion about matters concerning the entire #{make.name} Community.", category: 'General', make_id: make.id)
#     Forum.create(name: 'Newbs & FAQ', description: 'The Newbie & FAQs forum on Talking Cars is a good place to get started if you are new to forum based websites. Post here to get started and ask questions...', category: 'General', make_id: make.id)
#     Forum.create(name: 'Interior & Exterior Modification', description: 'The Interior & Exterior Modification & Care forum on Talking Cars is for discussion about interior, or exterior bits, in regard to their installation or maintenance.', category: 'General', make_id: make.id)
#     Forum.create(name: 'Car Care & Detailing', description: 'The Car Care & Detailing forum on Talking Cars is here to discuss ways to keep your car looking brand new years after purchase.', category: 'General', make_id: make.id)
#     Forum.create(name: 'Car Audio, Video & Security', description: 'The Car Audio, Video & Security forum on Talking Cars is for discussion about all car electronics.', category: 'General', make_id: make.id)
#     Forum.create(name: 'Motorsports', description: 'The Motorsports forum on Talking Cars is for all racing information from beginner amateur to seasoned professional.', category: 'General', make_id: make.id)
#     Forum.create(name: 'Proven Power', description: 'The Proven Power Bragging forum on Talking Cars is where you come to show the community what your car did at the track or on the Dyno. Find out who the fastest and best really is.', category: 'General', make_id: make.id)
#     Forum.create(name: "Member's Car Gallery", description: "The Member's Car Gallery forum on Talking Cars is here so you can post pictures of your car to share with the rest of the #{make.name} world and beyond.", category: 'General', make_id: make.id)
#     Forum.create(name: 'News & Rumors', description: "The News & Rumors forum on Talking Cars is where you will find the latest stories and rumors. Want to know what the scoop of the day is? Post your #{make.name} news and rumors here.", category: 'General', make_id: make.id)
#     Forum.create(name: 'Warranty Issues & SOA Problems', description: 'The Warranty Issues & SOA Problems forum on Talking Cars if for discussion about your warranty issues, general problems or questions regarding SOA warranties.', category: 'General', make_id: make.id)
#
#     Forum.create(name: 'General Technical', description: "The General Technical Forum on Talking Cars is for general discussion about matters concerning the entire #{make.name} Community.", category: 'Technical', make_id: make.id)
#     Forum.create(name: 'Normally Aspirated Powertrain', description: "The Normally Aspirated Powertrain forum on Talking Cars is for technical discussion about any NORMALLY ASPIRATED #{make.name} powertrain parts & problems. Discussion will include powertrain parts & problems both stock and aftermarket.", category: 'Technical', make_id: make.id)
#     Forum.create(name: 'Normally Aspirated with bolt-on Forced Induction Powertrain', description: "The Normally Aspirated with bolt-on Forced Induction Powertrain forum on Talking Cars is for technical discussion of powertrain parts & problems for any #{make.name} engine that has some form of turbo/supercharged added to it.", category: 'Technical', make_id: make.id)
#     Forum.create(name: 'Built Motor Discussion', description: "The Built Motor Discussion forum on Talking Cars deals with anything regarding 'Building, Modifying, or Swapping Engine Internal Components'.", category: 'Technical', make_id: make.id)
#     Forum.create(name: 'Engine Management & Tuning', description: "The Engine Management & Tuning forum on Talking Cars is for discussion about Standalone & Piggyback ECU's, Datalogging Software, and Tuning.", category: 'Technical', make_id: make.id)
#     Forum.create(name: 'Electrical & Lighting', description: "The Electrical & Lighting forum on Talking Cars is for technical discussion about any Electronics/Lighting related to any #{make.name}.", category: 'Technical', make_id: make.id)
#     Forum.create(name: 'Transmission (AT/MT) & Driveline', description: "The Transmission (AT/MT) & Driveline forum on Talking Cars is for technical discussion about any Factory/Aftermarket parts related to the #{make.name} transmission and driveline", category: 'Technical', make_id: make.id)
#     Forum.create(name: 'Brakes, Steering & Suspension', description: "The Brakes, Steering & Suspension forum on Talking Cars if for technical discussion about any aspect of a cars handling performance.", category: 'Technical', make_id: make.id)
#     Forum.create(name: 'Tire & Wheel', description: 'The Tire & Wheel forum on Talking Cars is for discussion about Tires and Wheels.', category: 'Technical', make_id: make.id)
#     Forum.create(name: 'Car Part Reviews', description: "The Car Part Reviews forum on Talking Cars is where you should post any and all reviews of car parts for any year or model #{make.name}.", category: 'Technical', make_id: make.id)
#
#     Forum.create(name: "Private 'For Sale' Classifieds", description: "The Private 'For Sale' Classifieds forums on Talking Cars are for the sale of anything owned by private owners only, no vendors allowed.", category: 'Classified', make_id: make.id)
#     Forum.create(name: "Private 'Wanted' Classifieds", description: "The Private 'Wanted' Classifieds forum on Talking Cars is where you can post about something you are looking to buy from either a vendor or a private owner.", category: 'Classified', make_id: make.id)
#     Forum.create(name: "Private Vehicle 'For Sale' Classifieds", description: "The Private Vehicle 'For Sale' Classifieds forum on Talking Cars is for any vehicle 'For Sale' by private owner only! No dealer, or 'selling for a friend' posts allowed!!", category: 'Classified', make_id: make.id)
#     Forum.create(name: "Vendor 'For Sale' Classifieds", description: "The Vendor 'For Sale' Classifieds forum on Talking Cars is for registered vendors of Talking Cars to sell 'IN-STOCK' items only.", category: 'Classified', make_id: make.id)


def set_forums(model)
  [
    {name: 'General Community', description: "The General Forum on Talking Cars is for general discussion about matters concerning the entire #{model.make.name} #{model.name} Community.", category: 'General', model_id: model.id},
    {name: 'Newbs & FAQ', description: 'The Newbie & FAQs forum on Talking Cars is a good place to get started if you are new to forum based websites. Post here to get started and ask questions...', category: 'General', model_id: model.id},
    {name: 'Interior & Exterior Modification', description: 'The Interior & Exterior Modification & Care forum on Talking Cars is for discussion about interior, or exterior bits, in regard to their installation or maintenance.', category: 'General', model_id: model.id},
    {name: 'Car Care & Detailing', description: 'The Car Care & Detailing forum on Talking Cars is here to discuss ways to keep your car looking brand new years after purchase.', category: 'General', model_id: model.id},
    {name: 'Car Audio, Video & Security', description: 'The Car Audio, Video & Security forum on Talking Cars is for discussion about all car electronics.', category: 'General', model_id: model.id},
    {name: 'Motorsports', description: 'The Motorsports forum on Talking Cars is for all racing information from beginner amateur to seasoned professional.', category: 'General', model_id: model.id},
    {name: 'Proven Power', description: 'The Proven Power Bragging forum on Talking Cars is where you come to show the community what your car did at the track or on the Dyno. Find out who the fastest and best really is.', category: 'General', model_id: model.id},
    {name: "Member's Car Gallery", description: "The Member's Car Gallery forum on Talking Cars is here so you can post pictures of your car to share with the rest of the #{model.make.name} #{model.name} world and beyond.", category: 'General', model_id: model.id},
    {name: 'News & Rumors', description: "The News & Rumors forum on Talking Cars is where you will find the latest stories and rumors. Want to know what the scoop of the day is? Post your #{model.make.name} #{model.name} news and rumors here.", category: 'General', model_id: model.id},
    {name: 'Warranty Issues & SOA Problems', description: 'The Warranty Issues & SOA Problems forum on Talking Cars if for discussion about your warranty issues, general problems or questions regarding SOA warranties.', category: 'General', model_id: model.id},

    {name: 'General Technical', description: "The General Technical Forum on Talking Cars is for general discussion about matters concerning the entire #{model.make.name} #{model.name} Community.", category: 'Technical', model_id: model.id},
    {name: 'Normally Aspirated Powertrain', description: "The Normally Aspirated Powertrain forum on Talking Cars is for technical discussion about any NORMALLY ASPIRATED #{model.make.name} #{model.name} powertrain parts & problems. Discussion will include powertrain parts & problems both stock and aftermarket.", category: 'Technical', model_id: model.id},
    {name: 'Normally Aspirated with bolt-on Forced Induction Powertrain', description: "The Normally Aspirated with bolt-on Forced Induction Powertrain forum on Talking Cars is for technical discussion of powertrain parts & problems for any #{model.make.name} #{model.name} engine that has some form of turbo/supercharged added to it.", category: 'Technical', model_id: model.id},
    {name: 'Built Motor Discussion', description: "The Built Motor Discussion forum on Talking Cars deals with anything regarding 'Building, Modifying, or Swapping Engine Internal Components'.", category: 'Technical', model_id: model.id},
    {name: 'Engine Management & Tuning', description: "The Engine Management & Tuning forum on Talking Cars is for discussion about Standalone & Piggyback ECU's, Datalogging Software, and Tuning.", category: 'Technical', model_id: model.id},
    {name: 'Electrical & Lighting', description: "The Electrical & Lighting forum on Talking Cars is for technical discussion about any Electronics/Lighting related to any #{model.make.name} #{model.name}.", category: 'Technical', model_id: model.id},
    {name: 'Transmission (AT/MT) & Driveline', description: "The Transmission (AT/MT) & Driveline forum on Talking Cars is for technical discussion about any Factory/Aftermarket parts related to the #{model.make.name} #{model.name} transmission and driveline", category: 'Technical', model_id: model.id},
    {name: 'Brakes, Steering & Suspension', description: "The Brakes, Steering & Suspension forum on Talking Cars if for technical discussion about any aspect of a cars handling performance.", category: 'Technical', model_id: model.id},
    {name: 'Tire & Wheel', description: 'The Tire & Wheel forum on Talking Cars is for discussion about Tires and Wheels.', category: 'Technical', model_id: model.id},
    {name: 'Car Part Reviews', description: "The Car Part Reviews forum on Talking Cars is where you should post any and all reviews of car parts for any year or model #{model.make.name} #{model.name}.", category: 'Technical', model_id: model.id},

    {name: "Private 'For Sale' Classifieds", description: "The Private 'For Sale' Classifieds forums on Talking Cars are for the sale of anything owned by private owners only, no vendors allowed.", category: 'Classified', model_id: model.id},
    {name: "Private 'Wanted' Classifieds", description: "The Private 'Wanted' Classifieds forum on Talking Cars is where you can post about something you are looking to buy from either a vendor or a private owner.", category: 'Classified', model_id: model.id},
    {name: "Vendor 'For Sale' Classifieds", description: "The Vendor 'For Sale' Classifieds forum on Talking Cars is for registered vendors of Talking Cars to sell 'IN-STOCK' items only.", category: 'Classified', model_id: model.id},
    {name: "Private Vehicle 'For Sale' Classifieds", description: "The Private Vehicle 'For Sale' Classifieds forum on Talking Cars is for any vehicle 'For Sale' by private owner only! No dealer, or 'selling for a friend' posts allowed!!", category: 'Classified', model_id: model.id}
  ]

end
