# This configuration file will be evaluated by Puma. The top-level methods that
# are invoked here are part of Puma's configuration DSL. For more information
# about methods provided by the DSL, see https://puma.io/puma/Puma/DSL.html.

workers ENV.fetch("WEB_CONCURRENCY") { 1 }
threads_count = ENV.fetch("RAILS_MAX_THREADS", 5)
threads threads_count, threads_count

preload_app!

# Removed or commented this line because DefaultRackup is no longer supported
# rackup DefaultRackup

port ENV.fetch("PORT") { 3000 }
environment ENV.fetch("RAILS_ENV") { "production" }

on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
#port ENV.fetch("PORT", 3000)

# Allow puma to be restarted by `bin/rails restart` command.
plugin :tmp_restart

# Specify the PID file. Defaults to tmp/pids/server.pid in development.
# In other environments, only set the PID file if requested.
pidfile ENV["PIDFILE"] if ENV["PIDFILE"]
