require 'rubygems'

$stdout = $stderr

generation = ENV.fetch('GENERATION') do
  fail "ERROR: Must supply a generation (e.g. `2' in `2.x.y.z') via ENV['GENERATION']"
end

gemspec_path = ENV.fetch('GEMSPEC') do
  fail "ERROR: Must supply a gemspec path via ENV['GEMSPEC']"
end

puts <<~TEXT
Loading Gemspec (#{gemspec_path})
- - -
TEXT

gemspec = Gem::Specification.load(gemspec_path)

if gemspec.nil?
  fail "Gemspec not found at #{gemspec_path}"
end

puts <<~TEXT
Gemspec #{gemspec_path} was loaded

TEXT

current_version = gemspec.version

next_version_segments = current_version.segments.map.with_index do |value, level|
  if level.zero?
    generation
  else
    value
  end
end

next_version = next_version_segments * '.'

dry_run = !ENV['DRY_RUN'].to_s.match?(/\A(?:off|no|n|false|f|0)\z/i)

command = <<~SH.chomp
ruby -p -i -e 'gsub(#{current_version.to_s.inspect}, #{next_version.to_s.inspect})' #{gemspec_path}
SH

puts <<~TEXT
#{'(Dry run) ' if dry_run}Replacing Version Identifier
- - -
Gem Name: #{gemspec.name}
Current Version: #{current_version}
Next Version: #{next_version}
Command: #{command}

TEXT

STDOUT.puts <<~TEXT
#{current_version}
#{next_version}
TEXT
STDOUT.flush
