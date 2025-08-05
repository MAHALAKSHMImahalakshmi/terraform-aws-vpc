variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "project" {
  type = string
  // irrespective of project it will work roboshop,expense
  //its module of the project
}
variable "environment" {
  type = string    //====> this mandatory variable should be provided . Here no default value 
}
variable "public_subnet_cidrs" {
  type = list(string)
  //2 subnet hence loop
}

variable "private_subnet_cidrs" {
  type = list(string)
  //2 subnet hence loop
}
variable "database_subnet_cidrs" {
  type = list(string)
  //2 subnet hence loop
}
variable "vpc_tags" {
  type = map(string)
  default= {}   // this is optional variable ,as here default value 
}
variable "igw_tags" {
  type = map(string)
  default= {}   // this is optional variable ,as here default value 
}

variable "public_subnet_tags" {
  type = map(string)
  default= {}   // this is optional variable ,as here default value 
}
variable "private_subnet_tags" {
  type = map(string)
  default= {}   // this is optional variable ,as here default value 
}
variable "database_subnet_tags" {
  type = map(string)
  default= {}   // this is optional variable ,as here default value 
}
variable "eip_tags" {
  type = map(string)
  default= {}   // this is optional variable ,as here default value 
}
variable "nat_gatway_tags" {
  type = map(string)
  default= {}   // this is optional variable ,as here default value 
}

variable "public_route_table_tags" {
  type = map(string)
  default= {}   // this is optional variable ,as here default value 
}


variable "private_route_table_tags" {
  type = map(string)
  default= {}   // this is optional variable ,as here default value 
}

variable "database_route_table_tags" {
  type = map(string)
  default= {}   // this is optional variable ,as here default value 
}

