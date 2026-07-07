# Mutations

### Schema
check mutations
```
{
  __schema {
    mutationType {
      fields {
        name
      }
    }
  }
}
```
#### Variables

### Register User
```
mutation RegisterUser($input: RegisterInput!) {
  register(input: $input) {
    user {
      id
      email
    }
    errors
  }
}
```
#### Variables
```
{
  "input": {
    "firstName": "Jes",
    "lastName": "Mava",
    "email": "jesus7@gmail.com",
    "password": "Pass123456"
  }
}
```

### Create Workspace
```
mutation CreateWorkspace($input: CreateWorkspaceInput!) {
  createWorkspace(input: $input) {
    workspace {
      id
      name
    }
    errors
  }
}
```
#### Variables
```
{"input": 
  {
    "name": "Engineering"
  }
}
```

#### Header
```
{
  "Authorization": "Bearer TOKEN"
}
```

### Login
```
mutation LoginUser($input: LoginInput!) {
  login(input: $input) {
    token
    user {
      id
      email
    }
    errors
  }
}
```

#### Variables
```
{
  "input": {
    "email": "jesus7@gmail.com",
    "password": "Pass123456"
  }
}
```
### CreateProject
```
mutation CreateProject($input: CreateProjectInput!) {
  createProject(input: $input) {
    project {
      id
      name
    }
    errors
		
  }
}
```

#### Variables
```
{"input": {
        "name": "Engineering Project2",
  			"workspaceId": 1
      }
  
}
```

#### Header
```
{
  "Authorization": "Bearer <Token>"
}
```

### Create Task
```
mutation CreateTask($input: CreateTaskInput!) {
  createTask(input: $input) {
    project {
      id
      name
    }
    errors
		
  }
}
```

#### Variables
```
{
  "input": {
        "title": "hw 3",
  			"projectId": 1,
    		"description": ""
      }
  
}
```
#### header
```
{
  "Authorization": "Bearer "
}
```

### Move Task
```
mutation MoveTask($input: MoveTaskInput!) {
  moveTask(input: $input) {
    task {
      title
    }
    errors
		
  }
}
```

#### Variables
```
{
  "input": {
        "taskId": 1,
  			"newPosition": 3
      }
  
}
```

#### header
```
{
  "Authorization": "Bearer "
}
```

# Queries

### me
```
query {
  me {
    id
    firstName
    lastName
    email
  }
}
```
#### Variables

### Register User
#### Variables

### Register User
#### Variables