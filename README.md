# Ansible Role: cloudera-hadoop 

An ansible playbook to deploy cloudera hadoop components to the cluster

# Description
The playbook is able to setup the required services for components:
* hadoop hdfs ( with HA support )
*	hadoop yarn map reduce
*	hive
*	hbase
*	impala
*	oozie
*	hue
*	postgresql 

The configuration is _very_ simple:
It’s only required to place hostname(s) to the appropriate group in hosts file, and the required services will be setup.

The playbook run configuration check tasks at start, and will stop if the configuration is not supported,
providing a descriptive error message. 

Some services such as yarn-nodemanager configured on each datanode host.
impala-server, hbase-regionserver will be also configured on datanodes if a host specified for impala-store-catalog or hbasemaster
group appropriately.

Oozie will be configured on hue host.

The playbook contain all configuration files in roles directories. If you need to add or change any parameter you can edit
the required configuration file which can be found in roles/<product>/[files|templates] directory.

Besides of cluster( or single host ) setup, the playbook also generates cluster manager configuration file located at workdir/services.xml.
Please visit [clinit manager home page](https://github.com/sergevs/clinit) and see [manual](https://github.com/sergevs/clinit/wiki) .
The rpm package can be downloaded from [clinit-1.0-ssv1.el6.noarch.rpm](https://github.com/sergevs/clinit/releases/download/1.0/clinit-1.0-ssv1.el6.noarch.rpm).
After clinit package installed you’ll be able to stop, start and see status of services of any service on any node.

clinit -S workdir/services.xml status
# Configuration

# Usage
To start deployment run:

    ansible-playbook -i hosts site.yaml 

if you have installed clinit you can also run:

    clinit -S workdir/services.xml status
    clinit -S workdir/services.xml tree

# Requirements
OS version: Redhat/CentOS 6
Cloudera Hadoop version: 5.4

The required for Cloudera Hadoop repositories have to be properly configured on the target hosts.
See also [official documentation](http://www.cloudera.com/content/www/en-us/documentation/enterprise/latest/topics/cdh_ig_yumrepo_local_create.html)

Java package(s) have to be available in the repository. You can download [jdk-8u65-linux-x64.rpm](http://www.oracle.com/technetwork/java/javase/downloads/java-archive-javase8-2177648.html#jdk-8u60-oth-JPR) from official oracle site

SSH key passwordless authentication must be configured for root account for all target hosts.

**se_linux** must be disabled

**remote_user = root** must be configured for ansible.

## License

MIT
