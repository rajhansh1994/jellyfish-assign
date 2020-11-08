###  VPC, two Public Subnets, Internet Gateway and Route Table 

resource "aws_vpc" "jellyfish" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "jellyfish"
  }
}

resource "aws_subnet" "public_us_east_1a" {
  vpc_id            = aws_vpc.jellyfish.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Public Subnet us-east-1a"
  }
}

resource "aws_subnet" "public_us_east_1b" {
  vpc_id            = aws_vpc.jellyfish.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Public Subnet us-east-1b"
  }
}

resource "aws_internet_gateway" "jellyfish_igw" {
  vpc_id = aws_vpc.jellyfish.id

  tags = {
    Name = "jellyfish - Internet Gateway"
  }
}

resource "aws_route_table" "jellyfish_public" {
  vpc_id = aws_vpc.jellyfish.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jellyfish_igw.id
  }

  tags = {
    Name = "Public Subnets Route Table for jellyfish_igw"
  }
}

resource "aws_route_table_association" "jellyfish_us_east_1a_public" {
  subnet_id      = aws_subnet.public_us_east_1a.id
  route_table_id = aws_route_table.jellyfish_public.id
}

resource "aws_route_table_association" "jellyfish_us_east_1b_public" {
  subnet_id      = aws_subnet.public_us_east_1b.id
  route_table_id = aws_route_table.jellyfish_public.id
}