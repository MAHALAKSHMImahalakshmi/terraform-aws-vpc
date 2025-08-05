resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  /*instance_tenancy - (Optional) A tenancy option for instances launched into the VPC.
    Default is default, which makes your instances shared on the host. 
    Using either of the other options (dedicated or host) costs at least $2/hr.*/
    enable_dns_hostnames = true
  tags = merge(local.common_tags,{
    Name = "${var.project}-${var.environment}"
  })
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
   #association with vpc automaticaly
   #unlike manually in aws console
tags = merge(
    var.igw_tags,
    local.common_tags,{
    Name = "${var.project}-${var.environment}"
  })
}

#availability zone
# roboshop-dev-us-east-1a
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidrs[count.index]
  //2 subnet hence loop list of 2 cider
  availability_zone = local.az_names[count.index]
  map_public_ip_on_launch = true // Make subnet suitable for public-facing workloads.
 //it is like frontend = public address when ever ec2 lunch assign automatically public address
  tags = merge(
    var.public_subnet_tags,
    local.common_tags,{
    Name = "${var.project}-${var.environment}-public-${local.az_names[count.index]}"
  })
}
resource "aws_subnet" "private" {

  count = length(var.private_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidrs[count.index]
  availability_zone =  local.az_names[count.index]
  //availability_zone = slice(data.aws_availability_zones.available.names,0,2)[count.index]
  tags = merge(
    var.private_subnet_tags,
    local.common_tags,{
    Name = "${var.project}-${var.environment}-private-${local.az_names[count.index]}"
  })
}

resource "aws_subnet" "database" {

  count = length(var.database_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.database_subnet_cidrs[count.index]
  availability_zone =  local.az_names[count.index]
  //availability_zone = slice(data.aws_availability_zones.available.names,0,2)[count.index]
  tags = merge(
    var.database_subnet_tags,
    local.common_tags,{
    Name = "${var.project}-${var.environment}-database-${local.az_names[count.index]}"
  })
}
 resource "aws_eip" "nat" {
 
  domain   = "vpc" // why domain
  tags = merge(
    var.eip_tags,
    local.common_tags,{
    Name = "${var.project}-${var.environment}-database-${local.az_names[count.index]}"
  })

}

resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id
// public[0] go to resource "aws_subnet" "public" {} get subnet_id   
   tags = merge(
    var.nat_gatway_tags,
    local.common_tags,{
    Name = "${var.project}-${var.environment}-database-${local.az_names[count.index]}"
  })

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.example]
}