app_path = File.dirname(File.dirname(Dir.pwd))
worker_processes 1
working_directory "#{app_path}/current"
listen "#{app_path}/shared/tmp/sockets/unicorn.sock", :backlog => 64
timeout 60
pid "#{app_path}/shared/tmp/pids/unicorn.pid"
stderr_path "#{app_path}/shared/log/unicorn.stderr.log"
stdout_path "#{app_path}/shared/log/unicorn.stdout.log"

preload_app true

before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "#{app_path}/current/Gemfile"
end

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
  old_pid = "#{ server.config[:pid] }.oldbin"
  unless old_pid == server.pid
    begin
      Process.kill :QUIT, File.read(old_pid).to_i
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

