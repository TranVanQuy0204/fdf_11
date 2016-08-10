Kaminari.configure do |config|
  config.default_per_page = 12
  config.page_method_name = :page_kimanari
  config.param_name = :page
end
