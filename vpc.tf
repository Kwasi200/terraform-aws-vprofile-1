



resource "aws_vpc" "vprofile-vpc" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "vprofile-vpc"
  }
  }



resource "aws_subnet" "public-sub1" {

  vpc_id            = aws_vpc.vprofile-vpc.id
  cidr_block        = var.public-sub1
  availability_zone = var.AZ-1

  tags = {
    Name = "public-sub1"
  }
}

# Public subnet2
resource "aws_subnet" "public-sub2" {
  vpc_id            = aws_vpc.vprofile-vpc.id
  cidr_block        = var.public-sub2
  availability_zone = var.AZ-2

  tags = {
    Name = "public-sub2"
  }
}
# Public subnet3
resource "aws_subnet" "public-sub3" {

  vpc_id            = aws_vpc.vprofile-vpc.id
  cidr_block        = var.public-sub3
  availability_zone = var.AZ-3

  tags = {
    Name = "public-sub3"
  }
}

# Private subnet1
resource "aws_subnet" "priv-sub1" {
  vpc_id            = aws_vpc.vprofile-vpc.id
  cidr_block        = var.priv-sub1
  availability_zone = var.AZ-1

  tags = {
    Name = "priv-sub1"
  }
}

# Private subnet2
resource "aws_subnet" "priv-sub2" {
  vpc_id            = aws_vpc.vprofile-vpc.id
  cidr_block        = var.priv-sub2
  availability_zone = var.AZ-2
  tags = {
    Name = "priv-sub2"
  }
}

# Private subnet3
resource "aws_subnet" "priv-sub3" {
  vpc_id            = aws_vpc.vprofile-vpc.id
  cidr_block        = var.priv-sub3
  availability_zone = var.AZ-3

  tags = {
    Name = "priv-sub3"
  }
}


# Creating Internet Gateway
# internet gateway
resource "aws_internet_gateway" "int-gatwy" {
  vpc_id = aws_vpc.vprofile-vpc.id

  tags = {
    Name = "int-gatwy"
  }
}

# Elastic Ip
resource "aws_eip" "nat_eip" {
  vpc                       = true
 # associate_with_private_ip = var.priv-sub1
  depends_on                = [aws_internet_gateway.int-gatwy]
  tags = {
    Name = "nat_eip"
  }
}


# Nat Gateway

resource "aws_nat_gateway" "Nat-gatwy" {
  allocation_id = aws_eip.nat_eip.id

  #Associate it with one of the public subnets
  subnet_id = aws_subnet.public-sub1.id
  # subnet_id      = aws_subnet.public_subnet2.id

  tags = {
    Name = "nat-gatwy"
  }
}





#resource "aws_eip" "nat_gateway" {
#  vpc = true
#}
#
#resource "aws_nat_gateway" "nat_gateway" {
#  allocation_id = aws_eip.nat_gateway.id
#  subnet_id = aws_subnet.nat_gateway.id
#  tags = {
#    "Name" = "DummyNatGateway"
#  }
#}
#
#output "nat_gateway_ip" {
#  value = aws_eip.nat_gateway.public_ip
#}

