
#
# simulating the vagrant and the VBoxManage scripts
#

require 'fileutils'

flavour = ARGV.shift
rest = ARGV.collect { |e| e.match(/\s/) ? e.inspect : e }.join(' ')

if flavour == '-vboxmanage'

  case rest
    when 'list vms'
      puts '"vm_1234" {12345678-1234-1234-1234-123456789000}'
    else
      puts [ flavour, rest ].join(' ')
  end

else #flavour == '-vagrant'

  case rest
    when 'box list'
      puts 'squeeze64'
      puts 'redhat5_2'
    else
      puts [ flavour, FileUtils.pwd, rest ].join(' ')
  end
end

