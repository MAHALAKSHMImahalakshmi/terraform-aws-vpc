//tags reparted used on 
// two variables can be mergerd where variables cannot
//locals can reassigned 

locals {
  common_tags = {
    project = var.project
    environment = var.environment
    terraform="true"
    //why?  terraform="true"
/*terraform = "true"
This tag is often used to help identify resources managed by Terraform, especially useful in distinguishing between manually-created and Terraform-created resources.

2. Variables cannot be reassigned in Terraform
variable blocks define input values.

Once set, their values cannot be changed or reassigned in the same execution.*/
  }
}
locals {
  az_names = slice(data.aws_availability_zones.available.names,0,2)
}
