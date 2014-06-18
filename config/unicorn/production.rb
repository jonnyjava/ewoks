root = ENV["ROOT_PROJECT_PRODUCTION"]
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.err.log"
stdout_path "#{root}/log/unicorn.out.log"

# Port configuration
listen "#{root}/tmp/sockets/ewoks.sock" , :backlog => 64
worker_processes 2
timeout 30
preload_app true

# Force the bundler gemfile environment variable to
# reference the capistrano "current" symlink
before_exec do |_|
  ENV["BUNDLE_GEMFILE"] = File.join(root, 'Gemfile')
end
