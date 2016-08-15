provider "aws" {
  region = "ap-northeast-1"
  profile = "lambda-handson-201608"
}


# DynamoDB
resource "aws_dynamodb_table" "dynamodb-table" {
    name = "handson-contact"
    read_capacity = 1
    write_capacity = 1
    hash_key = "Timestamp"
    attribute {
      name = "Timestamp"
      type = "S"
    }
    attribute {
      name = "Email"
      type = "S"
    }
    global_secondary_index {
      name = "EmailIndex"
      hash_key = "Email"
      write_capacity = 1
      read_capacity = 1
      projection_type = "INCLUDE"
      non_key_attributes = [ "Timestamp" ]
    }
}

# role for application
resource "aws_iam_role" "handson-app-role" {
    name = "handson-app-role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "dynamodb" {
  name = "AmazonDynamoDBFullAccess"
  roles = ["${aws_iam_role.handson-app-role.id}"]
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

resource "aws_iam_policy_attachment" "lambda" {
  name = "AWSLambdaFullAccess"
  roles = ["${aws_iam_role.handson-app-role.id}"]
  policy_arn = "arn:aws:iam::aws:policy/AWSLambdaFullAccess"
}
