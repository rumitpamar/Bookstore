



# resource "aws_ecs_cluster" "ecs_cluster" {
#   name = "${var.project}-cluster"
# }

# #######################   ECS task for migrator   #######################

# resource "aws_ecs_task_definition" "migrator_task_definition" {
#   family                   = "migrator"
#   requires_compatibilities = ["EC2"]
#   container_definitions = jsonencode([
#     {
#       "name" : "migrator",
#       "image" : "${aws_ecr_repository.ecr_repo[0].repository_url}:migrator-latest",
#       "portMappings" : [
#         {
#           "containerPort" : 80,
#           "hostPort" : 80
#         }
#       ],
#       "memory" : 512,
#       "memoryReservation" : 256,
#     },
#   ])
# }

# resource "aws_ecs_service" "migrator" {
#   name            = "migrator"
#   cluster         = aws_ecs_cluster.ecs_cluster.id
#   task_definition = aws_ecs_task_definition.migrator_task_definition.arn
#   desired_count   = 1
# }

# #######################   ECS task for app, auth, web   #######################

# resource "aws_ecs_task_definition" "app_auth_web_task_definition" {
#   family                   = "app-auth-web"
#   requires_compatibilities = ["EC2"]
#   container_definitions = jsonencode([
#     {
#       "name" : "app",
#       "image" : "${aws_ecr_repository.ecr_repo[0].repository_url}:app-latest",
#       "portMappings" : [
#         {
#           "containerPort" : 8080,
#           "hostPort" : 80
#         }
#       ],
#       "memory" : 512,  
#       "memoryReservation" : 256,  

#     },
#     {
#       "name" : "auth",
#       "image" : "${aws_ecr_repository.ecr_repo[0].repository_url}:auth-latest",
#       "portMappings" : [
#         {
#           "containerPort" : 8181,
#           "hostPort" : 81
#         }
#       ],
#       "memory" : 512,  
#       "memoryReservation" : 256,  
#     },
#     {
#       "name" : "web",
#       "image" : "${aws_ecr_repository.ecr_repo[0].repository_url}:web-latest",
#       "portMappings" : [
#         {
#           "containerPort" : 8282,
#           "hostPort" : 82
#         }
#       ],
#       "memory" : 512,  
#       "memoryReservation" : 256,  
#     },
#   ])
# }


# resource "aws_ecs_service" "app_auth_web" {
#   name            = "app-auth-web"
#   cluster         = aws_ecs_cluster.ecs_cluster.id
#   task_definition = aws_ecs_task_definition.app_auth_web_task_definition.arn
#   desired_count   = 0
#   depends_on      = [aws_ecs_service.migrator]
# }

# resource "aws_ecs_service" "app" {
#   name            = "app"
#   cluster         = aws_ecs_cluster.ecs_cluster.id
#   task_definition = aws_ecs_task_definition.app_auth_web_task_definition.arn
#   desired_count   = 1
#   depends_on      = [aws_ecs_service.app_auth_web]
# }

# resource "aws_ecs_service" "auth" {
#   name            = "auth"
#   cluster         = aws_ecs_cluster.ecs_cluster.id
#   task_definition = aws_ecs_task_definition.app_auth_web_task_definition.arn
#   desired_count   = 1
#   depends_on      = [aws_ecs_service.app_auth_web]
# }

# resource "aws_ecs_service" "web" {
#   name            = "web"
#   cluster         = aws_ecs_cluster.ecs_cluster.id
#   task_definition = aws_ecs_task_definition.app_auth_web_task_definition.arn
#   desired_count   = 1
#   depends_on      = [aws_ecs_service.app_auth_web]
# }













# data "external" "check_database" {
#   program = ["powershell.exe", "-File", "./db_check.ps1"]
# }




resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.project}-cluster"
}



#######################   ECS task for migrator   #######################



resource "aws_ecs_task_definition" "migrator_task_definition" {
  family                   = "migrator"
  requires_compatibilities = ["EC2"]
  container_definitions = jsonencode([
    {
      "name" : "migrator",
      "image" : "${aws_ecr_repository.ecr_repo.repository_url}:migrator-latest", #"nginx:latest"
      "portMappings" : [
        {
          "containerPort" : 80,
          "hostPort" : 8080
        }
      ],
      "memory" : 256,#2048, #256, #1024,
      "memoryReservation" : 128,#512,

    },
  ])
}

#######################   ECS task for auth   #######################



resource "aws_ecs_task_definition" "auth_task_definition" {
  family                   = "auth"
  requires_compatibilities = ["EC2"]
  container_definitions = jsonencode([
    {
      "name" : "auth-container",
      "image" : "${aws_ecr_repository.ecr_repo.repository_url}:auth-latest", #"nginx:latest"
      "portMappings" : [
        {
          "containerPort" : 80,
          "hostPort" : 8089 
        }
      ],
      "memory" : 256, #682, #256, #1024,
      "memoryReservation" : 128, #512,

    },
  ])
}

resource "aws_ecs_service" "auth" {
  name            = "auth"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.auth_task_definition.arn
  desired_count   = 1
  depends_on      = [aws_ecs_task_definition.migrator_task_definition]
}




#######################   ECS task for app   #######################

resource "aws_ecs_task_definition" "app_task_definition" {
  family                   = "app"
  requires_compatibilities = ["EC2"]
  container_definitions = jsonencode([
    {
      "name" : "app-container",
      "image" : "${aws_ecr_repository.ecr_repo.repository_url}:app-latest", #"nginx:latest"#
      "portMappings" : [
        {
          "containerPort" : 80,
          "hostPort" : 8088
        }
      ],
      "memory" : 256,#682, #256, #1024,
      "memoryReservation" : 128,#512,
    },
  ])
}

resource "aws_ecs_service" "app" {
  name            = "app"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.app_task_definition.arn
  desired_count   = 1
  depends_on      = [aws_ecs_task_definition.migrator_task_definition]
}




#######################   ECS task for web   #######################

resource "aws_ecs_task_definition" "web_task_definition" {
  family                   = "web"
  requires_compatibilities = ["EC2"]
  container_definitions = jsonencode([
    {
      "name" : "web",
      "image" : "${aws_ecr_repository.ecr_repo.repository_url}:web-latest",#"nginx:latest"#
      "portMappings" : [
        {
          "containerPort" : 80,
          "hostPort" : 8086
        }
      ],
      "memory" :256,#682, #256, #1024,
      "memoryReservation" : 128, #@512,

    },
  ])
}

resource "aws_ecs_service" "web" {
  name            = "web"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.web_task_definition.arn
  desired_count   = 1
  depends_on      = [aws_ecs_task_definition.migrator_task_definition]
}






