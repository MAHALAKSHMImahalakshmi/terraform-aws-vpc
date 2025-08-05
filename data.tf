data "aws_availability_zones" "available" {
  state = "available"
}
/*
output "azs_info" {
  value = data.aws_availability_zones.available
  //written in module in order fetch go test folder 
}*/