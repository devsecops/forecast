###Elastalert Integration ###

This is the initial integration of elastalert for the Forecast project. Elastalert is a open source project built by the team at Yelp that allows for the creation of rules and alerts that are contained inside of elasticsearch indices.


##Prerequesites##

*Python 2.6
*Elasticsearch
*AWS EMR Cluster

##Installation##

Elastalert can be installed using the elastalert_install.rb ruby script. The script is based on other EMR bootstrap scripts that have been provided by AWS and can be specified as a bootstrap action on EMR cluster boot. To do this you will need to upload the elastalert_install.rb script to a S3 bucket that is accessible by your EMR cluster.

Additionally, you can just run the elastalert_install.rb script on an existing EMR cluster to add in the elastalert functionality to a cluster that already has elasticsearch, logstash and kibana installed.

After the install script has been run there is still a manual step needed.

1. The elastalert index needs to be created

```
cd /home/hadoop/elastalert
elastalert-create-index
```
Choose the defaults

2. Verify the index has been created
```
 curl localhost:9200/_cat/indices
```

Should return something like this

```
green open elastalert_status 5 1 0 0 1.4kb 720b
```

3. Read the elastalert docs to learn how to write alerts: http://elastalert.readthedocs.org/en/latest/

    
##Todo##
* Fully automate the installation of elastalert
* Example elastalert rule creation for AWS Cloudtrail events
* Bundled rules to allow for quick start
* Create example alert for email alert
* Create example alert for slack alert
* Create example alert for Jira alert
* Create example alert for Pager Duty alert
