
cd ../..

# cd into the directory.
cd ./iac/26001000-dns

terraform fmt

terraform init

terraform validate

terraform plan -out main.tfplan

terraform show main.tfplan

terraform apply main.tfplan

nslookup -type=SOA viveklearn.xyz

# Server:  UnKnown
# Address:  202.88.131.89

# Non-authoritative answer:
# viveklearn.xyz
#         primary name server = dns1.registrar-servers.com
#         responsible mail addr = hostmaster.registrar-servers.com
#         serial  = 1658818904
#         refresh = 43200 (12 hours)
#         retry   = 3600 (1 hour)
#         expire  = 604800 (7 days)
#         default TTL = 3601 (1 hour 1 sec)

# viveklearn.xyz  nameserver = dns2.registrar-servers.com
# viveklearn.xyz  nameserver = dns1.registrar-servers.com
# dns1.registrar-servers.com      internet address = 156.154.132.200
# dns2.registrar-servers.com      internet address = 156.154.133.200
# dns1.registrar-servers.com      AAAA IPv6 address = 2610:a1:1024::200
# dns2.registrar-servers.com      AAAA IPv6 address = 2610:a1:1025::200

nslookup -type=NS viveklearn.xyz

# Server:  UnKnown
# Address:  202.88.131.89

# Non-authoritative answer:
# viveklearn.xyz  nameserver = dns2.registrar-servers.com
# viveklearn.xyz  nameserver = dns1.registrar-servers.com

# dns1.registrar-servers.com      internet address = 156.154.132.200
# dns2.registrar-servers.com      internet address = 156.154.133.200
# dns1.registrar-servers.com      AAAA IPv6 address = 2610:a1:1024::200
# dns2.registrar-servers.com      AAAA IPv6 address = 2610:a1:1025::200

terraform state list

terraform plan -destroy -out main.destroy.tfplan

terraform show main.destroy.tfplan

terraform apply main.destroy.tfplan

Remove-Item -Recurse -Force .terraform/modules

Remove-Item -Recurse -Force .terraform

Remove-Item terraform.tfstate

Remove-Item terraform.tfstate.backup

Remove-Item main.tfplan

Remove-Item main.destroy.tfplan

Remove-Item .terraform.lock.hcl

