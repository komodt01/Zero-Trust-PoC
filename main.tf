
provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = "t3.micro"
  subnet_id = aws_subnet.public_subnet.id
  tags = {
    Name = "ZeroTrustWebServer"
  }
}

resource "aws_cognito_user_pool" "pool" {
  name = "zero-trust-user-pool"
}

resource "aws_api_gateway_rest_api" "api" {
  name        = "zero-trust-api"
  description = "API Gateway for Zero Trust project"
}
