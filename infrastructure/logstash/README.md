# Logstash Config Files

This directory contains bare bones logstash configuration files and configureations to get logstash connected to a s3 bucket to allow the ingestion of logs

##Basic Setup

After the EMR cluster is up and running ssh into the Master node as the hadoop user to install the s3 plugin for logstash. Logstash is installed into the hadoop user's home directory by the bootstrap scripts.

The s3 plugin for Logstash can be installed using the following commands:

```
cd ~/logstash/logstash-1.5.3/

./bin/plugin install logstash-input-s3

```

Logstash should then be configured to pull logs from a s3 bucket in the same account that the EMR cluster is in.

The following is an example of a basic logstash.conf file that will connect to a bucket in hte same account and begin pulling in logs and push the collected logs into elastic search. Replace YOUR_S3_BUCKET_GOES_HERE with the s3 bucket that you want to use to ingest logs. For testing you can use the s3 bucket that was configured for the EMR cluster logging during the EMR cluster setup.

```
input { s3 { bucket => "YOUR_S3_BUCKET_GOES_HERE" } }

output {
  elasticsearch { host => "localhost" protocol => "http" port => "9200"}
}

```

The logstash.conf file should be written to a place that the hadoop user has access to. In this example it is written to the ~/logstash/logstash-1.5.3 directory.

To begin running logstash you will need to start it form the command line. It is always best to check the syntax of the configuration file before starting or re-starting logstash. To check to make sure the config file is valid you can use the following command from within the ~/logstash/logstash-1.5.3 directory:

```
./bin/logstash -f logstash.conf --configtest
```
This command should output

```
Configuration OK
```

Now that logstash is ready to run it is necessary to start logstash from the command line. From inside the ~/logstash/logstash-1.5.3 directory runt the following command:

```
./bin/logstash -f logstash.conf -v -l logstash_log &
```

The logs will be put into a default logstash index in elastic search. To list the indexes in your elastic search installation you can use the following curl command.

```
curl localhost:9200/_cat/indices
```

To access the web interface for Kibana on the EMR cluster it is necessary to open up access to the Kibana interfcace in the EMR Master security group. Be careful to only allow IP addresses you want to have access to the Kibana interface as Kibana does not have authentication enabled by default. Otherwise it is possible to use a SSH tunnel to access the Kibana interface. This can be done using the following command.

```
ssh -i ~/.ssh/YOUR_EMR_PEM -l ec2-user -L 5000:YOUR_EMR_MASTER_PUBLIC_IP:80 hadoop@YOUR_EMR_MASTER_PUBLIC_IP
```

Now open a browser and browse to localhost:5000 and you will be able to access your Kibana web interface.
