
require 'fileutils'

flavour = ARGV.shift
rest = ARGV.join(' ')

if flavour == '-vboxmanage'

  if rest == 'list vms'
    puts '"vm_1234" {12345678-1234-1234-1234-123456789000}'
  end

else #flavour == '-vagrant'

  puts [ FileUtils.pwd, rest ].join(' ')
end

