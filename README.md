# Setup 

1. Download MovieLens 1M Data Sets & unzip
  * http://grouplens.org/node/12
  * unzip ml-1m.zip to db/ml-1m
1. bundle install
1. Import MovieLens 1M Data Sets to database
  * rake db:create
  * rake dev:build
  * rake dev:import

# Demo

## recommendify

  ```
  rake dev:mysql_to_recommendify```
  rails c

  recommender = MyRecommendify.new
  recommender.for(Movie.first.id)  
  ``` 

## recommendable
  
  ```
  rake dev:mysql_to_recommendable
  rails c

  user = User.first
  Recommendable::Helpers::Calculations.update_similarities_for(user.id)
  Recommendable::Helpers::Calculations.update_recommendations_for(user.id)
  user.recommended_movies
  user.similar_raters
  
  ```

