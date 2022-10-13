###################### VPC #####################

resource "aws_vpc" "trf_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.trf-vpc}"
  }
}

############################# Public_Subnet #########################

resource "aws_subnet" "public1" {
  depends_on = [
    aws_vpc.trf_vpc,
  ]
  cidr_block        = var.public_subnet1_cidr
  vpc_id            = aws_vpc.trf_vpc.id
  availability_zone = var.availability_zone1
  tags = {
    Name       = "${var.public_subnetName1}"
    Visibility = "Public"
  }
}

# public subnet #2 
resource "aws_subnet" "public2" {
  depends_on = [
    aws_vpc.trf_vpc,
  ]

  cidr_block        = var.public_subnet2_cidr
  vpc_id            = aws_vpc.trf_vpc.id
  availability_zone = var.availability_zone2
  tags = {
    Name       = "${var.public_subnetName2}"
    Visibility = "Public"
  }
}

# public subnet #3
resource "aws_subnet" "public3" {
  depends_on = [
    aws_vpc.trf_vpc,
  ]

  cidr_block        = var.public_subnet3_cidr
  vpc_id            = aws_vpc.trf_vpc.id
  availability_zone = var.availability_zone3
  tags = {
    Name       = "${var.public_subnetName3}"
    Visibility = "Public"
  }
}

################################ Private_Subnet ########################

# Private Subnet #1
resource "aws_subnet" "private1" {
  depends_on = [
    aws_vpc.trf_vpc,
  ]

  cidr_block        = var.private_subnet1_cidr
  vpc_id            = aws_vpc.trf_vpc.id
  availability_zone = var.availability_zone1
  tags = {
    Name       = "${var.private_subnetName1}"
    Visibility = "Private"
  }
}

# private subnet #2 
resource "aws_subnet" "private2" {
  depends_on = [
    aws_vpc.trf_vpc,
  ]

  cidr_block        = var.private_subnet2_cidr
  vpc_id            = aws_vpc.trf_vpc.id
  availability_zone = var.availability_zone2
  tags = {
    Name       = "${var.private_subnetName2}"
    Visibility = "Private"
  }
}

################################# Internet Gateway ############################

# Creating an Internet Gateway for the VPC
resource "aws_internet_gateway" "Internet_Gateway" {
  depends_on = [
    aws_vpc.trf_vpc,
    aws_subnet.public1,
    aws_subnet.public2,
    aws_subnet.public3
  ]

  # VPC in which it has to be created!
  vpc_id = aws_vpc.trf_vpc.id

  tags = {
    Name = "${var.IGName}"
  }
}

# Creating an Route Table for the public subnet!
resource "aws_route_table" "Public_Subnet_RT" {
  depends_on = [
    aws_vpc.trf_vpc,
    aws_internet_gateway.Internet_Gateway
  ]

  # VPC ID
  vpc_id = aws_vpc.trf_vpc.id

  # NAT Rule
  route {
    cidr_block = var.nat_cidr
    gateway_id = aws_internet_gateway.Internet_Gateway.id
  }

  tags = {
    Name = "${var.public_rtbname}"
  }
}

###################### Creating a resource for the Route Table Association!####################

resource "aws_route_table_association" "RT_IG_Association" {

  depends_on = [
    aws_vpc.trf_vpc,
    aws_subnet.public1,
    aws_subnet.public2,
    aws_subnet.public3,
    aws_route_table.Public_Subnet_RT
  ]

  # Public Subnet ID
  subnet_id = aws_subnet.public1.id
  #  Route Table ID
  route_table_id = aws_route_table.Public_Subnet_RT.id
}

resource "aws_route_table_association" "RT_IG_Association1" {

  depends_on = [
    aws_vpc.trf_vpc,
    aws_subnet.public1,
    aws_subnet.public2,
    aws_subnet.public3,
    aws_route_table.Public_Subnet_RT
  ]

  # Public Subnet ID
  subnet_id = aws_subnet.public2.id
  #  Route Table ID
  route_table_id = aws_route_table.Public_Subnet_RT.id
}

resource "aws_route_table_association" "RT_IG_Association3" {

  depends_on = [
    aws_vpc.trf_vpc,
    aws_subnet.public1,
    aws_subnet.public2,
    aws_subnet.public3,
    aws_route_table.Public_Subnet_RT
  ]

  # Public Subnet ID
  subnet_id = aws_subnet.public3.id
  #  Route Table ID
  route_table_id = aws_route_table.Public_Subnet_RT.id
}
# Creating an Elastic IP for the NAT Gateway!
resource "aws_eip" "NG-ElasticIP" {
  depends_on = [
    aws_internet_gateway.Internet_Gateway
  ]
  vpc = true
  tags = {
    Name = "${var.NG-ElasticIPTag}"
  }

}
########################## Creating a NAT Gateway!#####################

resource "aws_nat_gateway" "NAT_GATEWAY" {
  allocation_id = aws_eip.NG-ElasticIP.id
  subnet_id = aws_subnet.public1.id
  tags = {
    Name = "${var.NG-name}"
  }
  depends_on = [aws_eip.NG-ElasticIP]

}

# Creating a Route Table for the Nat Gateway!
resource "aws_route_table" "NAT_Gateway_RT" {
  
  depends_on = [
    aws_nat_gateway.NAT_GATEWAY
  ]

  vpc_id = aws_vpc.trf_vpc.id

  route {
    cidr_block     = var.NG_route_cidr
    nat_gateway_id = aws_nat_gateway.NAT_GATEWAY.id
  }

  tags = {
    Name = "${var.NG_route_name}"
  }

}

# Creating an Route Table Association of the NAT Gateway route
# table with the Private Subnet!
resource "aws_route_table_association" "Nat_Gateway_RT_Association1" {
  depends_on = [
    aws_route_table.NAT_Gateway_RT
  ]

  #  Private Subnet ID for adding this route table to the DHCP server of Private subnet!
  subnet_id = aws_subnet.private1.id

  # Route Table ID
  route_table_id = aws_route_table.NAT_Gateway_RT.id
}

resource "aws_route_table_association" "Nat_Gateway_RT_Association2" {
  depends_on = [
    aws_route_table.NAT_Gateway_RT
  ]

  #  Private Subnet ID for adding this route table to the DHCP server of Private subnet!
  subnet_id = aws_subnet.private2.id

  # Route Table ID
  route_table_id = aws_route_table.NAT_Gateway_RT.id
}

