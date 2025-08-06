data "aws_availability_zones" "available" {
  state = "available"
}
/*
output "azs_info" {
  value = data.aws_availability_zones.available
  //written in module in order fetch go test folder 
}*/
data "aws_vpc" "default" {
  default = true
}

data "aws_route_table" "main" {
  vpc_id = data.aws_vpc.default.id
  filter {
    name = "association.main" //why filter
    /*Filtering with "association.main" = "true" is how you 
    programmatically and reliably select the main route table for
     a VPC in Terraform, even if there are multiple route tables present
     
     .*/
    values = ["true"]
  }
}