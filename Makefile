plan:
	rm -rf *.terraform .terraform.lock.hcl
	terraform init -backend-config=state.tfvars
	terraform plan

apply:
	rm -rf *.terraform .terraform.lock.hcl
	terraform init -backend-config=state.tfvars
	terraform apply -auto-approve
	rm -rf *.terraform .terraform.lock.hcl


destroy:
	rm -rf .terraform .terraform.lock.hcl
	terraform init -backend-config=state.tfvars
	terraform destroy -auto-approve
	rm -rf .terraform .terraform.lock.hcl\







#destroy:
#	rm -rf *.terraform
#	terraform init -backend-config=state.tfvars
#	terraform destroy -auto-approve -var-file=env-dev/inputs.tfvars
#	rm -rf *.terraform

