
case node['PDF-sge']['type']

when 'server'
	"TBD"

when 'client'
	directory '/var/spool/sge-8.1.6' do
		owner 'sge'
		group 'sge'
		mode '0755'
		action :create		
	end

	case node['PDF-generic']['site']
	when 'pvg'
		directory '/var/spool/sge-8.1.6-sjc' do
			owner 'sge'
			group 'sge'
			mode '0755'	
			action :create
		end
	end

else
	Chef::Log.info( "PDF-sge: PDF-sge type value is empty, skip this recipe." )
	return

end
