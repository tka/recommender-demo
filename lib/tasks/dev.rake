# -*- encoding : utf-8 -*-
require 'csv'
namespace :dev do

  desc "Rebuild system"
  task :build => ["tmp:clear", "log:clear", "db:drop", "db:create", "db:migrate", "db:seed" ]

  desc "Import MovieLens data to MySQL"
  task :import => :environment do
    Rake::Task["dev:build"].invoke
    category_models = []
    ActiveRecord::Base.transaction do
      CSV.foreach File.join(Rails.root, 'db', 'ml-1m', 'movies.dat'), :col_sep => "::", encoding: "iso8859-15:UTF-8"  do |c|
        movie = Movie.new(id: c[0], name: c[1])
        movie.send(:create_record)
        categories = c[2].split("|").each do |category_name|
          category = category_models.find{|x| x.name == category_name }
          unless category 
            category = Category.find_or_create_by( name: category_name)
            category_models << category 
          end
          category.movies << movie

        end
      end
    end
    ActiveRecord::Base.transaction do
      CSV.foreach File.join(Rails.root, 'db', 'ml-1m', 'users.dat'), :col_sep => "::" do |c|
        User.new(gender: c[0], age: c[1], occupation_id: c[2]).send(:create_record)
      end
    end
    ActiveRecord::Base.transaction do
      CSV.foreach File.join(Rails.root, 'db', 'ml-1m', 'ratings.dat'), :col_sep => "::" do |c|
        ActiveRecord::Base.connection.execute("insert into ratings (user_id, movie_id, rate, created_at) values (#{c[0]}, #{c[1]}, #{c[2]}, '#{Time.at(c[3].to_i).strftime('%Y%m%d%H%M%S')}')")
      end
    end
  end

  desc "Import data to redis for Recommendify"
  task "mysql_to_recommendify" => :environment do
    recommender = MyRecommendify.new
    ActiveRecord::Base.connection.select('select user_id, group_concat(movie_id) movie_ids  from ratings group by user_id order by user_id').each {|x|
      puts "user: #{x["user_id"]} => #{x["movie_ids"]}"
      recommender.movie_items.add_set(x["user_id"], x["movie_ids"].split(/,/))
    }
  end

  desc "Import data to redis for Recommendable"
  task "mysql_to_recommendable" => :environment do
    User.find_each do |user|
      puts "user: #{user.id}"
      user.movies.each do |movie|
        user.like(movie)
      end
    end
  end

end
