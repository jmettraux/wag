
#
# simulating the vagrant and the VBoxManage scripts
#

require 'fileutils'

flavour = ARGV.shift
rest = ARGV.join(' ')

if flavour == '-vboxmanage'

  if rest == 'list vms'
    puts '"vm_1234" {12345678-1234-1234-1234-123456789000}'
  else
    puts [ flavour, FileUtils.pwd, rest ].join(' ')
  end

else #flavour == '-vagrant'

  if rest == 'box list'
    puts 'squeeze64'
    puts 'redhat5_2'
  else
    puts [ flavour, FileUtils.pwd, rest ].join(' ')
  end
end

