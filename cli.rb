require 'rubygems'
require 'commander'

Commander.configure do
  program :name, 'w3'
  program :version, '1.0.0'
  program :description, 'commands for simple solidity development'

  command :compile do |c|
    c.syntax = 'w3 compile'
    c.description = 'Compiles solidity code in contracts and puts the output in build'
    c.action do |args, options|
        `solc -o build --bin --abi contracts/*.sol`
    end
  end

  command :clear do |c|
    c.syntax = 'w3 clear'
    c.description = 'Deletes all files in build directory'
    c.action do |args, options|
        `rm -rf build/*`
    end
  end
end