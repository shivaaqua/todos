working_directory "/var/projects/todos"
pid "/var/projects/todos/tmp/pids/unicorn.pid"
stderr_path "/var/projects/todos/log/unicorn.log"
stdout_path "/var/projects/todos/log/unicorn.log"

listen "/tmp/unicorn.todo.sock"
worker_processes 2
timeout 30
