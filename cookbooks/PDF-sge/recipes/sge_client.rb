## 
## when use 'owner' and 'group' in 'directory' resource, always got user id does not exist error.
## can't find reason even with service restart. I guess it's due to NIS, maybe Chef uses different way to check user id
## So, use "execute" resource to manually chown
## 

case node['PDF-sge']['type']

when 'server'
	"TBD"

when 'client'

	directory '/var/spool/sge-8.1.6' do
		#owner 'sge'
		#group 'sge'
		mode '0755'
		action :create		
		#notifies :restart, "service[ypbind]", :immediately
	end

	execute 'change_owner1' do
		command 'chown sge:sge /var/spool/sge-8.1.6'
	end

	service "ypbind" do
	        action :nothing
	end

	case node['PDF-generic']['site']
	when 'pvg'
		directory '/var/spool/sge-8.1.6-sjc' do
			#owner 'sge'
			#group 'sge'
			mode '0755'	
			action :create
		end

	        execute 'change_owner2' do
	                command 'chown sge:sge /var/spool/sge-8.1.6-sjc'
	        end

	end

else
	Chef::Log.info( "PDF-sge: PDF-sge type value is empty, skip this recipe." )
	return

end
