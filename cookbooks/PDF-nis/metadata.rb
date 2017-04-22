name 'PDF-nis'
maintainer 'Harry Chen'
maintainer_email 'zheng.chen@pdf.com'
license 'all_rights'
description 'Installs/Configures PDF-nis'
long_description 'Installs/Configures PDF-nis'
version '0.1.0'

# This is depends on cookbook chef-nis, in PDF-nis cookbook, we just restart the ypbind to make sure NIS is configured properly before any other cookbook being run.

depends 'nis'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/PDF-nis/issues' if respond_to?(:issues_url)

# The `source_url` points to the development reposiory for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/PDF-nis' if respond_to?(:source_url)
