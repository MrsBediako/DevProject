# creating network for Dev project in EU-west-2

resource "aws_vpc" "dev_project_1" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "dev_project_1"

  }
}

# creating public subnet

resource "aws_subnet" "prod_pub_sub1" {
  vpc_id            = aws_vpc.dev_project_1.id
  cidr_block        = var.public_cidr
  availability_zone = var.az1

  tags = {
    Name = "prod_pub_sub1"
  }
}

resource "aws_subnet" "prod_pub_sub2" {
  vpc_id            = aws_vpc.dev_project_1.id
  cidr_block        = var.public_2_cidr
  availability_zone = var.az2

  tags = {
    Name = "prod_pub_sub2"
  }
}

resource "aws_subnet" "prod_pub_sub3" {
  vpc_id            = aws_vpc.dev_project_1.id
  cidr_block        = var.public_3_cidr
  availability_zone = var.az2

  tags = {
    Name = "prod_pub_sub3"
  }
}



# creating private subnet

resource "aws_subnet" "prod_priv_sub1" {
  vpc_id            = aws_vpc.dev_project_1.id
  cidr_block        = var.private_cidr
  availability_zone = var.az1

  tags = {
    Name = "prod_priv_sub1"
  }
}

resource "aws_subnet" "prod_priv_sub2" {
  vpc_id            = aws_vpc.dev_project_1.id
  cidr_block        = var.private_2_cidr
  availability_zone = var.az2

  tags = {
    Name = "prod_priv_sub2"
  }
}

# creating public route table

resource "aws_route_table" "prod_pub_route_table" {
  vpc_id = aws_vpc.dev_project_1.id


  tags = {
    Name = "prod_pub_route_table"
  }
}

# creating private route table

resource "aws_route_table" "prod_priv_route_table" {
  vpc_id = aws_vpc.dev_project_1.id


  tags = {
    Name = "prod_priv_route_table"
  }
}


# associate public subnet with the public route table

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.prod_pub_sub1.id
  route_table_id = aws_route_table.prod_pub_route_table.id
}

resource "aws_route_table_association" "public_assoc_1" {
  subnet_id      = aws_subnet.prod_pub_sub2.id
  route_table_id = aws_route_table.prod_pub_route_table.id
}

resource "aws_route_table_association" "public_assoc_2" {
  subnet_id      = aws_subnet.prod_pub_sub3.id
  route_table_id = aws_route_table.prod_pub_route_table.id
}


# associate private subnet with the private route table

resource "aws_route_table_association" "private_assoc_1" {
  subnet_id      = aws_subnet.prod_priv_sub1.id
  route_table_id = aws_route_table.prod_priv_route_table.id
}

resource "aws_route_table_association" "private_assoc_2" {
  subnet_id      = aws_subnet.prod_priv_sub2.id
  route_table_id = aws_route_table.prod_priv_route_table.id
}


# internet gateway

resource "aws_internet_gateway" "prod_IGW" {
  vpc_id = aws_vpc.dev_project_1.id

  tags = {
    Name = "prod_IGW"
  }
}

# associating internet gateway to the public route table

resource "aws_route" "prod_IGW_assoc" {
  route_table_id         = aws_route_table.prod_pub_route_table.id
  gateway_id             = aws_internet_gateway.prod_IGW.id
  destination_cidr_block = var.destination_cidr
}

# allocating elastic ip address

resource "aws_eip" "eip_nat_gateway" {
  vpc = true

  tags = {
    Name = "eip_nat_gateway"
  }
}

# creating Nat gateway

resource "aws_nat_gateway" "prod_nat_gateway" {
  allocation_id = aws_eip.eip_nat_gateway.id
  subnet_id     = aws_subnet.prod_pub_sub1.id

  tags = {
    Name = "prod_nat_gateway"
  }
}

# associating nat gateway to the private route table

resource "aws_route" "prod_nat_association" {
  route_table_id         = aws_route_table.prod_priv_route_table.id
  gateway_id             = aws_nat_gateway.prod_nat_gateway.id
  destination_cidr_block = var.destination_cidr
}
