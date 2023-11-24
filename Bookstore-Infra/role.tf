data "aws_iam_policy_document" "ecs_agent" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_agent" {
  name               = "ecs-agent"
  assume_role_policy = data.aws_iam_policy_document.ecs_agent.json
}

resource "aws_iam_instance_profile" "ecs_agent" {
  name = "ecs-agent"
  role = aws_iam_role.ecs_agent.name
}

resource "aws_iam_role_policy_attachment" "ecs_agent" {
  role       = aws_iam_role.ecs_agent.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

# data "aws_iam_policy_document" "ecs_agent" {
#   statement {
#     actions = [
#       "sts:AssumeRole",
#     ]

#     principals {
#       type        = "Service"
#       identifiers = ["ec2.amazonaws.com"]
#     }
#   }

#   statement {
#     actions = [
#       "secretsmanager:GetSecretValue",
#     ]

#     resources = ["arn:aws:secretsmanager:*:*:secret:*"]  # Update this with the appropriate ARN for your secrets
#   }
# }



# resource "aws_iam_role" "ecs_agent" {
#   name               = "ecs-agent"
#   assume_role_policy = data.aws_iam_policy_document.ecs_agent.json
# }

# resource "aws_iam_instance_profile" "ecs_agent" {
#   name = "ecs-agent"
#   role = aws_iam_role.ecs_agent.name
# }

# resource "aws_iam_role_policy_attachment" "ecs_agent" {
#   role       = aws_iam_role.ecs_agent.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
# }



# data "aws_iam_policy_document" "ecs_agent" {
#   statement {
#     actions = [
#       "sts:AssumeRole",
#     ]

#     principals {
#       type        = "Service"
#       identifiers = ["ec2.amazonaws.com"]
#     }
#   }

#   statement {
#     actions = [
#       "secretsmanager:GetSecretValue",
#     ]

#     resources = ["arn:aws:secretsmanager:*:*:secret:*"]  # Update this with the appropriate ARN for your secrets
#   }
# }

# resource "aws_iam_role" "ecs_agent" {
#   name               = "ecs-agent"
#   assume_role_policy = data.aws_iam_policy_document.ecs_agent.json
# }

# resource "aws_iam_instance_profile" "ecs_agent" {
#   name = "ecs-agent"
#   role = aws_iam_role.ecs_agent.name
# }
# resource "aws_iam_role_policy_attachment" "ecs_agent" {
#   role       = aws_iam_role.ecs_agent.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
# }



# data "aws_iam_policy_document" "ecs_agent" {
#   statement {
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["ec2.amazonaws.com"]
#     }
#   }
# }

# resource "aws_iam_role" "ecs_agent" {
#   name               = "ecs-agent"
#   assume_role_policy = data.aws_iam_policy_document.ecs_agent.json
# }

# resource "aws_iam_instance_profile" "ecs_agent" {
#   name = "ecs-agent"
#   role = aws_iam_role.ecs_agent.name
# }

# resource "aws_iam_policy" "secretsmanager_policy" {
#   name        = "SecretsManagerPolicy"
#   description = "Allows GetSecretValue from Secrets Manager"
  
#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Effect   = "Allow",
#       Action   = "secretsmanager:GetSecretValue",
#       Resource = "*",  # You can specify a specific ARN here instead of "*" to limit access
#     }]
#   })
# }

# resource "aws_iam_policy_attachment" "secretsmanager_attachment" {
#   name       = "SecretsManagerAttachment"
#   roles      = [aws_iam_role.ecs_agent.id]
#   policy_arn = aws_iam_policy.secretsmanager_policy.arn
# }
