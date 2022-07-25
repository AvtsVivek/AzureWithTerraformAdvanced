# Dns 

- This builds on the previous example and adds a private DNS zone.

- Note the app1.conf file.

- The followiing must be disabled

```t
ProxyPass / http://10.1.11.241/
ProxyPassReverse / http://10.1.11.241/
```

- And the following must be enabled.

```t
ProxyPass / http://applb.terraformguru.com/
ProxyPassReverse / http://applb.terraformguru.com/
```