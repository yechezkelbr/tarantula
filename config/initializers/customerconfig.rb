# Include hook code here

Dir.glob("#{Rails.root}/lib/customerconfig/app/**/*.rb") do |path|
  require path
end

if CustomerConfig.table_exists?
  failing = []
  
  CustomerConfig.all.each do |cc|
    failing << cc.name if cc.respond_to?(:required?) and cc.required? and cc.value.blank?
  end

  unless failing.empty?
    puts "WARNING! Required customer configs not provided: #{failing.join(', ')}. " +
         "Use rake db:config or db:config:set."
  end
end
