require_relative '../coconut'

namespace :coconut do
  desc 'Swap the current development environment'
  task :swap, [:customer] => [:environment] do |t, args|
    Coconut::SwapService.new(customer: args[:customer]).start
  end

  desc 'Fetch all customer configurations'
  task :fetch, [:customer] => [:environment] do |t, args|
    Coconut::FetchService.new(customer: args[:customer]).start
  end
end
