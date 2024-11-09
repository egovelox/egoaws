Cloud configs


```bash

terraform init

terraform plan -var-file='variables.tfvars' -out ./plan 

terraform apply "./plan"

terraform state show aws_instance.ego_server

terraform destroy -auto-approve -var-file='variables.tfvars'
