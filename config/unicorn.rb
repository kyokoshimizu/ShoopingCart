app_path = File.dirname(File.dirname(Dir.pwd))
worker_processes 2
working_directory "#{app_path}/current"
listen "#{app_path}/shared/tmp/sockets/unicorn.sock", :backlog => 64
timeout 60
pid "#{app_path}/shared/tmp/pids/unicorn.pid"
stderr_path "#{app_path}/shared/log/unicorn.stderr.log"
stdout_path "#{app_path}/shared/log/unicorn.stdout.log"


before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "#{app_path}/current/Gemfile"
end
