# Final Project GIGIH 2.0 - Family Catering

Table of contents:

* [Database Design](#database-design)

* [Application Workflow](#application-workflow)

* [API Request](#api-request)

  * [Category](#category)

  * [Menu](#menu)

  * [Order](#order)

  * [Additional Requirement](#additional-requirement)

In this project, I created an API application where the UI of the application does not exist. I created this project on my local machine first, and after finishing some features I moved to Replit so that my project can adapt to Replit environment. At this moment, this project can only run in Replit because when I tried to run it on my local machine, it gave me some errors (Next time i will delete this part when it's fixed). I will explain the database design of this project first.

## Database Design

![image](https://user-images.githubusercontent.com/48941105/164591078-92307aa9-ccbd-46fb-8e5b-061b45abe031.png)

As shown in the image above, there are three main tables for this project, that is `Category`, `Menu`, and `Order` tables. Because the `Category` and `Menu` tables has many-to-many relationship, the `Menu_Category` join table was created to handle their communication. Same thing happened with the `Order` and `Menu` tables which produce the `Order_Menu` table. When we place an order, we can order several menus with its quantity. That's why on the `Order_Menu` table there are additional attributes to handle it.

## Application Workflow

Before we talk about how to send the API request, there's something we should know about what we need to do to make this application run properly. The workflow of this project is:

1. Create `Category` data
2. Create `Menu` data
3. Create `Order` data

The workflow must be followed as shown above so that this application can run properly.

## API Request

I will describe how to run this application properly with this little story. Pak Gagah wants to add his menu list into application so that all customer can see the available menu. But, Pak Gagah must add category data first so that later when he creating menu data, Pak Gagah can add category data to the menu data.

*note: this step will only works in Replit. I will modify it later. Peace...

### Category

#### GET

Pak Gigih wants to see list of categories, so Pak Gigih can send request like below:

```bash
curl -X GET https://gigih-family-catering-biggdaddyy.gojek22.repl.co/api/v1/categories \
-H 'Content-type: application/json'
```

#### POST

Looks like Pak Gigih wants to add a new category to the application. Pak Gigih wants to add `Indonesia` as a new category. And also, Pak Gigih can add description of category when create a new category. So, Pak Gigih can make a request like the one below:

```bash
curl -X POST https://gigih-family-catering-biggdaddyy.gojek22.repl.co/api/v1/categories \
-H 'Content-type: application/json' \
-d '{ "category": { "name": "Indonesia", "description": "Indonesian food" } }'
```

*note: we can change the value of `name` and `description`

Pak Gigih also added `Local` category to the application with the same way that he did earlier, but he changed the `name` value from `Indonesia` to `Local`. Now, Pak Gigih has two categories, that is `Indonesia` and `Local`.

#### PUT

Oh no. Pak Gigih made a mistake. He forgot to change the description of `Local` category. It hasn't changed when he created `Local` category. Pak Gigih wants to modify his category so it can be clearly to describe the category. This is the request that Pak Gigih can use:

```bash
curl -X PUT https://gigih-family-catering-biggdaddyy.gojek22.repl.co/api/v1/categories/2 \
-H 'Content-type: application/json' \
-d '{ "category": { "name": "Local", "description": "Local food" } }'
```

*note: we can change the value of `name` and `description`

*note: `2` in URL is ID of the category. we can change it with category id that we want to modify

#### DELETE

When Pak Gigih went to restroom, his wife added new category to the application. Pak Gigih doesn't want people to disturb hiw work. So, he decide to delete the new category data that his wife made earlier. Pak Gigih can use this request to do it:

```bash
curl -X DELETE https://gigih-family-catering-biggdaddyy.gojek22.repl.co/api/v1/categories/3 \
-H 'Content-type: application/json'
```

*note: `3` in URL is ID of the category. we can change it with category id that we want to delete

### Menu

#### GET

Now, Pak Gigih can add menu to the application. Before that, here is the request to get all data of menus from the application:

```bash
curl -X GET https://gigih-family-catering-biggdaddyy.gojek22.repl.co/api/v1/menus \
-H 'Content-type: application/json'
```

#### POST

Pak Gigih want to add `Nasi Padang` as his first menu data. When create a new menu data, we can add name of the menu, price, description of the menu, and also add category of the menu. To do that, he can send this request:

```bash
curl -X POST https://gigih-family-catering-biggdaddyy.gojek22.repl.co/api/v1/menus \
-H 'Content-type: application/json' \
-d '{ "menu": { "name": "Nasi Padang", "price": 1.5, "description": "Yummy" }, "category": { "category_name": "Indonesia" } }'
```

*note: we can change the value of `menu`, `price`, `description`, and also `category_name`.

Also, Pak Gigih add `Arsik` as a new menu with the same request but he changed all of the variable value to fit the menu data of `Arsik`.

#### PUT

Hmm... Looks like the price from the `Arsik` menu doesn't match. It's too cheap. So, Pak Gigih send this request to change the `Arsik` menu data:

```bash
curl -X PUT https://gigih-family-catering-biggdaddyy.gojek22.repl.co/api/v1/menus/2 \
-H 'Content-type: application/json' \
-d '{ "menu": { "name": "Arsik", "price": 3.2, "description": "Batak Pride" } }'
```

*note: we can change the value of `menu`, `price`, and `description`. And also, `2` in URL is ID of the menu. we can change it with menu id that we want to modify

#### DELETE

When Pak Gigih add more menu, he's not sure about the price and decide to delete it. This is request that Pak Gigih can send:

```bash
curl -X DELETE https://gigih-family-catering-biggdaddyy.gojek22.repl.co/api/v1/menus/3 \
-H 'Content-type: application/json'
```

*note: `3` in URL is ID of the menu. we can change it with menu id that we want to delete

### Order

#### GET

Now, Pak Gigih ready to work. LET'S GO!!!

Pak Gigih ready to receive any order based on menu that he made. To see order lists, Pak Gigih send this request:

```bash
curl -X GET https://gigih-family-catering-biggdaddyy.gojek22.repl.co/api/v1/orders \
-H 'Content-type: application/json' \
-d '{ "filter": { "filter_name": "" } }'
```

*note: we give empty data `filter` to get all of order data. We will talk about this things in the other section.

#### POST

Kio is one of Pak Gigih's loyal customers. Kio always order foods from Pak Gigih. Kio wants to order Nasi Padang like he usually does. Because Kio likes to eat, he order three Nasi padang (Just like me). Then, Pak Gigih adds this order into the application so that Pak Gigih has a record of the order. When create an order data, status of the order automatically filled with `NEW`. Pak Gigih can save the record of order with this request:

```bash
curl -X POST https://gigih-family-catering-biggdaddyy.gojek22.repl.co/api/v1/orders \
-H 'Content-type: application/json' \
-d '{ "order": { "customer_name": "Kio", "customer_email": "kio@gigih.com" }, "menu": { "menu_name": "Nasi Padang", "quantity": 3 } }'
```

*note: we can change the value of `customer_name`, `customer_email`, `menu_name`, and  `quantity`.

#### PUT

After place an order, Kio immediately pay the bill. Then, Kio informed Pak Gigih that he had already paid the bill and sent proof of payment. Pak Gigih wants to update Kio's order, so status of his order change to `PAID`. Here is a request that Pak Gigih can use:

```bash
curl -X PUT https://gigih-family-catering-biggdaddyy.gojek22.repl.co/api/v1/orders/1 \
-H 'Content-type: application/json' \
-d '{ "update_order": { "customer_name": "Kio", "customer_email": "kio@gigih.com", "status": "PAID" } }'
```

*note: we can change the value of `customer_name`, `customer_email`, and `status`. And also, `1` in URL is ID of the order. we can change it with order id that we want to modify

#### DELETE

If there is an order that we want to delete, we can use this request:

```bash
curl -X DELETE https://gigih-family-catering-biggdaddyy.gojek22.repl.co/api/v1/orders/1 \
-H 'Content-type: application/json'
```

*note: `1` in URL is ID of the order. we can change it with order id that we want to delete

### Additional Requirement

If we want to add more categories into menu, we can use this request:

```bash
curl -X POST https://gigih-family-catering-biggdaddyy.gojek22.repl.co/api/v1/menu_categories \
-H 'Content-type: application/json' \
-d '{ "menu_category": { "menu_id": @menu_name, "category_id": @category_name } }'
```

*note:

* `@menu_name` = Fill it with name of menu that we want to add more categories
* `@category_name` = Fill it with name of category that we want to add into menu

If we want to add more menus into order, we can use this request:

```bash
curl -X POST https://gigih-family-catering-biggdaddyy.gojek22.repl.co/api/v1/order_menus \
-H 'Content-type: application/json' \
-d '{ "order_menu": { "order_id": @order_id, "menu_id": @menu_name, "quantity": @quantity } }'
```

*note:

* `@order_id` = ID of order that we want to add more menus
* `@menu_name` = Fill it with name of menu that we want to add into order
* `@quantity` = Fill it with number of menus we want to make

If we want to see daily report, we can use this request:

```bash
curl -X GET https://gigih-family-catering-biggdaddyy.gojek22.repl.co/api/v1/orders \
-H 'Content-type: application/json' \
-d '{ "filter": { "filter_name": "daily" } }'
```

*note: Just like we want to get all order data, but we send `daily` parameter to request.
