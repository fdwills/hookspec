require 'rspec'
RSpec::Matchers.define :include_file do |file_name|
  match do |files|
    files.empty? || files.any?{ |f| f.eql? file_name }
  end
end
