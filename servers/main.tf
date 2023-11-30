provider "aws" {
  region = var.region

}


resource "aws_vpc" "vpc_geolocation" {
  cidr_block = var.cidr_block
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name  = "vpc_geolocation"
  }

}

resource "aws_internet_gateway" "igw_geolocation" {
  vpc_id = aws_vpc.vpc_geolocation.id
 
  tags = {
    Name = "igw_geolocation"
  }
}

resource "aws_subnet" "public-subnet" {
    vpc_id            = aws_vpc.vpc_geolocation.id
    cidr_block        = var.cidr_subnet
    availability_zone = var.az
  
    tags = {
      Name = "public-subnet_geolocation"
    }
  }

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc_geolocation.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_geolocation.id
  }
  tags = {
    Name = "Public-table"
  }
}



resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-rt.id
}


resource "aws_security_group" "sgwebserver" {
  vpc_id      = aws_vpc.vpcfruits.id
  name        = "webserver-SG"
  description = "Allow SSH access to developers"
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 8181
    to_port     = 8181
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  #defining outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name  = "sgwebserver"
  }
}

resource "aws_instance" "jenkins-server" {
  instance_type     = "t2.micro"
  ami               = "ami-09d56f8956ab235b3"
  availability_zone = "us-east-1a"
  key_name          = "devops"
     tags = {
       Name = "jenkins_server"
     }
}

resource "aws_instance" "sonarqube-server" {
    instance_type     = "t2.micro"
    ami               = "ami-09d56f8956ab235b3"
    availability_zone = "us-east-1a"
    key_name          = "devops"
       tags = {
         Name = "sonarqube_server"
       }
  
  }
  resource "aws_instance" "build-server" {
    instance_type     = "t2.micro"
    ami               = "ami-09d56f8956ab235b3"
    availability_zone = "us-east-1a"
    key_name          = "devops"
       tags = {
         Name = "build1_server"
       }

  }
  resource "aws_instance" "staging-server" {
    instance_type     = "t2.micro"
    ami               = "ami-09d56f8956ab235b3"
    availability_zone = "us-east-1a"
    key_name          = "devops"
       tags = {
         Name = "staging_server"
       }
  
  }

  resource "aws_instance" "prod-server" {
    instance_type     = "t2.micro"
    ami               = "ami-09d56f8956ab235b3"
    availability_zone = "us-east-1a"
    key_name          = "devops"
       tags = {
         Name = "production_server"
       }
    }