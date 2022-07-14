
# cd into the directory.
cd ./iac/0101100-vm-nsg

cd ../..

terraform fmt

# Launch Terraform console
terraform console

type("A simple string") # REturns string type

type(23) # REturns number

type(["Apple", "Ballon"]) # REturns tuple

type([1, 234]) # REturns tuple

type([1, "234sdf"]) # REturns tuple

exit