Cloud configs


```bash

terraform init

terraform plan -out ./plan

terraform apply "./plan"

terraform state show aws_instance.ego_fisdn_server
