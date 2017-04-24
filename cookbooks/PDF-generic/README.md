# PDF-generic cookbook


This cookbook should be the first cookbook on the run list for any PDF newly installed machine.
It will configure following parts

- Disable services
- Add mail aliases
- Change root password and add SSH key
- Set NTP servers

## Supports

- RHEL/CentOS 5.x, 6.x

## Depends

- ntp

## Attributes

- disable_services:  The list of services which need to be disabled

- mail_alias:  The list of mail alias added in /etc/aliases, format is like "root: abc@pdf.com"

- role:  The role of the node (machine), current support : "db", "cv", "IT"

- domain:  Supports "pvg"/"pvg.pdf.com", "pdfs"/"pdf.com"

- \* ["ntp"]["servers"]:  List of ntp servers, this attribute is for "ntp" cookbook


## Recipes

### default

## Authors

- Author: Harry Chen
