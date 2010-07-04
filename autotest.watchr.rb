puts "\n### Watching specs###\n"
 
def cmd() 'spec -O spec/spec.opts '; end
 
def run_all_specs
  puts "\nRunning entire suite..."
  system(cmd + 'spec/')
end
 
def run_spec(spec)
  if File.exists?(spec)
    puts "Running #{spec}"
    system(cmd + spec)
    run_all_specs if $?.exitstatus == 0
  end
end

watch('^spec\/.*\/.*_spec\.rb') {|md| run_spec(md[0]) }
watch('^app/(.*)\.rb') {|md| run_spec("spec/#{md[1]}_spec.rb") }
# watch('spec/spec_helper.rb') {|md| run_all_specs }

# Ctrl-\
Signal.trap('QUIT') do
 puts "\n### Running all specs###\n"
 run_all_specs
end
       
# Ctrl-C
Signal.trap('INT') { abort("\n") }
