require File.join(File.dirname(__FILE__), '..', 'lib', 'decision_tree')

Dir[File.join(File.dirname(__FILE__), 'fixtures', '**', '*.rb')].each do |file|
  require file
end