# A sample Guardfile
# More info at https://github.com/guard/guard#readme

## Uncomment and set this to only include directories you want to watch
# directories %w(app lib config test spec features) \
#  .select{|d| Dir.exists?(d) ? d : UI.warning("Directory #{d} does not exist")}

## Note: if you are using the `directories` clause above and you are not
## watching the project directory ('.'), then you will want to move
## the Guardfile to a watched dir and symlink it back, e.g.
#
#  $ mkdir config
#  $ mv Guardfile config/
#  $ ln -s config/Guardfile .
#
# and, you'll have to watch "config/Guardfile" instead of "Guardfile"

interactor :off

# Add files and commands to this file, like the example:
#   watch(%r{file/path}) { `command(s)` }
#
guard :shell do
  watch(/(lib|tests\/)(.*)\.rb$/) do |m|
    file = m[0]
	puts "File changed: #{file}"
    test_file = file[/_test\.rb/] ? file : file.sub(/\.rb/, '_test.rb')
    commands = 
		"bundle exec rake test",
		"bundle exec rubocop -D #{file}"
	generator = 
		"bin/generate isogram",
		"git --no-pager diff exercises/isogram/isogram_test.rb"
 	command = commands.join(' && ')
    p command
    system(command)
	system(generator.join(' && '))
  end
end
