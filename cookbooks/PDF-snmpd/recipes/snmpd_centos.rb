template "/etc/snmp/snmpd.conf" do
        source PDF-snmpd-centos.erb
        mode "0644"
end
