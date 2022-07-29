
mkdir ssl-self-signed

cd ../..

cd ./iac/33001000-az-app-gateway-ssl-https-redirect-error-pages

cd ssl-self-signed

openssl req -newkey rsa:2048 -nodes -keyout httpd.key -x509 -days 7300 -out httpd.crt

# Noe create the pfx file.

openssl pkcs12 -export -out httpd.pfx -inkey httpd.key -in httpd.crt -passout pass:vivek
