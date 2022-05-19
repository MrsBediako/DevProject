# creating network for cloud project 

resource "aws_vpc" "rock_project" {
  cidr_block          = "10.0.0.0/16"
  instance_tenancy    = "default"
  enable_dns_hostnames = true
  enable_dns_support  = true

  tags = {
    Name = "rock_project"

  }
}

# creating public subnet

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.rock_project.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "public_subnet"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.rock_project.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "public_subnet_1"
  }
}



# creating private subnet

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.rock_project.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "private_subnet"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.rock_project.id
  cidr_block        = "10.0.20.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "private_subnet_1"
  }
}

# creating public route table

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.rock_project.id


  tags = {
    Name = "public_route_table"
  }
}

# creating private route table

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.rock_project.id


  tags = {
    Name = "private_route_table"
  }
}


# associate public subnet with the public route table

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_assoc_1" { 
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}


# associate private subnet with the private route table

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_assoc_1" { 
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table.id
}


# internet gateway

resource "aws_internet_gateway" "rock_IGW" {
  vpc_id = aws_vpc.rock_project.id

  tags = {
    Name = "rock_IGW"
  }
}

# associating internet gateway to the public route table

resource "aws_route" "rock_IGW_assoc" {
  route_table_id            = aws_route_table.public_route_table.id
  gateway_id = aws_internet_gateway.rock_IGW.id
  destination_cidr_block    = "0.0.0.0/0"
}