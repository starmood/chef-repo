

%w{net-snmp}.each do |package|
 
  package package do
    action :install
  end
end

template "/etc/snmp/snmpd.conf" do
        source "PDF-snmpd-centos.erb"
        mode "0644"
end

%w{snmpd}.each do |service|
 
  service service do
    action [ :enable, :start ]
  end
end
