#!/usr/bin/ruby
require 'rubygems'
require 'json'
require 'emr/common'
require 'rexml/document'

def run(cmd)
  raise "Command failed: #{cmd}" unless system(cmd)
end

def sudo(cmd)
  run("sudo #{cmd}")
end

@is_master = Emr::JsonInfoFile.new('instance')['isMaster'].to_s == 'true'
@target_dir = "/home/hadoop/elastalert/"

def install_logstash(target_dir)
  run "sudo yum -y install git"
  run "cd #{@target_dir}; git clone https://github.com/Yelp/elastalert.git"
  run "mv #{@target_dir}/config.yaml.example #{@target_dir}/config.yaml"
  run "sudo pip install --upgrade setuptools"
  run "sudo /usr/bin/pip-2.6 install --upgrade argparse elasticsearch jira==0.32 jsonschema mock python-dateutil PyStaticConfiguration pyyaml boto"
  run "cd #{@target_dir}; sudo python setup.py install"
  run "sed -i -- 's/es_host: elasticsearch.example.com/es_host: 127.0.0.1/g' #{@target_dir}/config.yaml"
  run "sed -i -- 's/es_port: 14900/es_port: 9200/g' #{@target_dir}/config.yaml"
end


if @is_master==true
  install_logstash(@target_dir)
end
