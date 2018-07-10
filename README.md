# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* 

Some advices
---
To support Chrome OPTION and PUT requests add following lines to *application.rb* file
```
config.middleware.insert_before 0, Rack::Cors do
    allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options, :put, :delete]
    end
end
```    
It's important to have symbol *:put* in *:methods* array.