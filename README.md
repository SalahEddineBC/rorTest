# ROR test  

### Routes 
#### `POST /api/v1/users/`  
to create a new User
body should contain username and password. eg.  
```
{
  "username":"your_username",
  "password":"your_password",
}
```
#### `POST /login`  
to connect and get the authorization token  
body should contain username and password. eg.  
```
{
  "username":"your_username",
  "password":"your_password",
}
```  
the response will contain a token that should be used when trying to request protected routes
#### `/api/v1/blogs`  
full CRUD opertaions available and following JsonAPI guidelines - No token required  
#### `/api/v1/comments`  
full CRUD opertaions available and following JsonAPI guidelines - No token required 
#### `POST /api/v1/comments`  
to Create a new comment, token must be provided in request headers within 'Authorization' header and following this format: `Bearer tokenxxxxxxxxx` 
the body of request should contain the blog_id and the content of comment like this:
```
{
  "blog_id":"",1
  "content":"HAHAHAHA",
}
```
A USER IS ALLOWED TO COMMENT ON TWO BLOGS ONLY IN 24 HOURS PERIOD.


