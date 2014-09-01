Rails.application.config.assets.paths << "#{Rails.root}/vendor/assets/*"
Rails.application.config.assets.paths << "#{Rails.root}/vendor/assets/fonts"
Rails.application.config.assets.paths << "#{Rails.root}/vendor/assets/javascripts"
Rails.application.config.assets.paths << "#{Rails.root}/vendor/assets/stylesheets"
Rails.application.config.assets.precompile << Proc.new { |path|
  if path =~ /\.(eot|otf|svg|ttf|woff)\z/
    true
  end
}
