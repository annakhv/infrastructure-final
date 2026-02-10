#!/bin/bash
yum install -y httpd

COMPUTE_MACHINE_UUID=$(cat /sys/devices/virtual/dmi/id/product_uuid | tr '[:upper:]' '[:lower:]')
COMPUTE_INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

cat <<HTML > /var/www/html/index.html
<html>
  <body>
    <h1>This message was generated on instance ${COMPUTE_INSTANCE_ID}</h1>
    <p>with the following UUID ${COMPUTE_MACHINE_UUID}</p>
  </body>
</html>
HTML

systemctl start httpd
systemctl enable httpd
