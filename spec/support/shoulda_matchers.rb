require 'shoulda/matchers'

Shoulda::Matchers.configure do |config|
  config.integrate do |integrator|
    integrator.test_framework :rspec
    integrator.library :rails
  end
end