require "cap_vagrant/version"
require 'thor'
require 'erb'

class App < Thor

  desc "Setup a vagrant stage file.", "Create a vagrant stage file for your capistrano deployment."
  method_option :name, :type => :string, :default => "vagrant", :aliases => "-n", :desc => "The name you want to give the stage."
  method_option :update, :type => :boolean, :aliases => '-u', :desc => "If you ever restart your VM, it might change port info on you.  This will just update the port value."
  method_option :version, :type => :boolean
  def setup
    if options[:version]
      puts CapVagrant::VERSION
      exit
    end
    check_path?('Capfile', "Have you already setup Capistrano?")
    check_path?('config/deploy', "Are you using the multistage extension?")
    check_path?('Vagrantfile', "Have you already setup Vagrant?")

    ssh_details = {'HostName' => 'host', 'User' => 'user', 'Port' => 'port', 'IdentityFile' => "keys"}
    vars = {'name' => options[:name]}
    
    ssh_config=`vagrant ssh-config`.split("\n  ") ;  result=$?.success?
    abort "Calling vagrant ssh-config failed." unless result
    
    ssh_config.each do |i|
      k,v = i.split(" ")
      vars[ssh_details[k]] = v if ssh_details[k]
    end

    stage_file = File.join('.', 'config', 'deploy', "#{options[:name]}.rb")
    if options[:update]
      check_path?(stage_file)
      text = File.read(stage_file)
      replace = text.gsub(/:port.*\n/, ":port] = #{vars['port']}\n")
      File.open(stage_file, 'w') do |f|
        f.puts replace
      end
    else
      config = ERB.new(File.read(File.join(File.dirname(__FILE__), 'templates', 'stage.rb.erb')))
      File.open(stage_file, 'w') do |f|
        f.write config.result(binding)
      end
    end
  end

  default_task :setup

  no_tasks do
    def check_path?(path, message = '')
      full_path = File.expand_path(path)
      unless File.exists?(full_path)
        abort "Could not find `#{full_path}`? #{message}"
      end
    end
  end
end
