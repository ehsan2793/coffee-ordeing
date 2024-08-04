Resource: TEST Server Endpoints
Endpoints
Get all orders:

method: GET

https://island-bramble.glitch.me/test/orders

Create a new order:

method: POST

https://island-bramble.glitch.me/test/orders

Body:

{ 
"name": "John Doe", 
"coffeeName": "Hot Coffee", 
"total": 4.50, 
"size": "Medium"
}
Delete an order: 

method: DELETE

https://island-bramble.glitch.me/test/orders/:id 

Update an order:

method: PUT  

https://island-bramble.glitch.me/test/orders/:id

Body:

{ 
"name": "John Doe Edit", 
"coffeeName": "Hot Coffee Edit", 
"total": 2.50, 
"size": "Small"
}



Resource: PROD Server Endpoints
Endpoints
Get all orders:

method: GET

https://island-bramble.glitch.me/orders

Create a new order:

method: POST

https://island-bramble.glitch.me/newOrder

Body:

{ 
"name": "John Doe", 
"coffeeName": "Hot Coffee", 
"total": 4.50, 
"size": "Medium"
}
Delete an order: 

method: DELETE

https://island-bramble.glitch.me/orders/:id 



Update an order:

method: PUT  

https://island-bramble.glitch.me/orders/:id

Body:

{ 
"name": "John Doe Edit", 
"coffeeName": "Hot Coffee Edit", 
"total": 2.50, 
"size": "Small"
}
