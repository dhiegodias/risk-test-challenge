# README

* Ruby version
`Ruby 3.0.0`

* Configuration
Attached you can find the PostgresSQL docker-compose to run the database in a container.
`docker volume create desafio-risk-test-volume` to create the docker-volume
`docker-compose up` to get container running
`rails s` to get rails server running

* Database creation
`rails db:migrate` to create the tables
`rails db:seed` to populate the database with the sample csv provided

* Database creation
`rails db:migrate` to create the tables

* API
The API expect a payload such as:
```
{
"transaction_id" : 2342357,
"merchant_id" : 29744,
"user_id" : 97051,
"card_number" : "434505******9116",
"transaction_date" : "2019-11-31T23:16:32.812632",
"transaction_amount" : 373,
"device_id" : 285475
}
```

and the response will be such as:
```
{
"transaction_id" : 2342357,
"recommendation" : "approve"
}
```



* Important regarding the delivery:
I would like to apologize in advance for not delivering the test cases of the application. I refactored the code in order to apply DDD and Clean Architecture, but I had some major problems getting things to work in WSL2/Ubuntu properly. You will find the context of Transaction inside the Controllers folder, I couldnt make it load properly outside the main folders, I inteded to make it outside the App folder to keep the business rules a part, I was kind of unsure about making anything that could damage the project so close to the deadline.