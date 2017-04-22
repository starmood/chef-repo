guard :foodcritic, all_on_start: false do
  watch(%r{attributes/.+\.rb$})
  watch(%r{providers/.+\.rb$})
  watch(%r{recipes/.+\.rb$})
  watch(%r{resources/.+\.rb$})
end

guard :rspec, failed_mode: :none, all_after_pass: false, all_on_start: false do
  watch(%r{^spec/unit/recipes/(.+)_spec\.rb$})
  watch(%r{^recipes/(.+)\.rb$}) { |m| "spec/unit/recipes/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')      { 'spec' }
end

