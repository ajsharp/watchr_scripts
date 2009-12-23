# Use this watchr script to target a single file.
#
# Example
# =======
# watchr one.watchr model_name

def print_stats(time, &block)
  $stdout.puts "File Changed. Re-running specs..."
  start_time = time.call

  yield

  end_time   = time.call
  $stdout.puts "Test Duration: #{end_time - start_time} seconds"
end

@class_name   ||= ARGV.pop
@spec_options ||= "--colour --format s --loadby mtime --reverse"
@time         ||= lambda { Time.now.to_f }

$stdout.puts "Now watching #{@class_name}_spec.rb"

watch("spec/.*/#{@class_name}_spec\.rb") { |md| 
  print_stats(@time) { system("spec #{@spec_options} #{md[0]}") }
}


