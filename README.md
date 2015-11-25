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

The playbook contain all configuration files in roles directories. If you need to add or change any parameter you can edit
the required configuration file which can be found in roles/_service_/[files|templates] directory.

The playbook run configuration check tasks at start, and will stop if the configuration is not supported,
providing a descriptive error message. 

Besides of cluster( or single host ) setup, the playbook also generates cluster manager configuration file located at workdir/services.xml.
Please visit [clinit manager home page](https://github.com/sergevs/clinit) and see [manual](https://github.com/sergevs/clinit/wiki) .
The rpm package can be downloaded from [clinit-1.0-ssv1.el6.noarch.rpm](https://github.com/sergevs/clinit/releases/download/1.0/clinit-1.0-ssv1.el6.noarch.rpm).
After clinit package installed you’ll be able to stop, start and see status of services on any node.

# Configuration
Service configuration performed using the hosts file. The empty hosts file is supplied with playbook. **You must not remove any existing group**. Leave the group empty if you don't need services the group configures.

#### Hosts file groups description:
* **[namenodes]** : configures _namenode_ services, 1 or 2 hosts are allowed. HA HDFS will be configured in the case of 2 hosts.
* **[datanodes]** : configures _datanode_ services, at least one host is required
* **[yarnresourcemanager]** : configures _mapreduce_ yarn resource manager, exactly 1 host is required. _node manager_ services will be configured on **[datanodes]** hosts.
* **[zookeepernodes]** : confiugures _zookeeper_ services. 3 or 5 hosts is required for HA in the case 2 **[namenodes]** hosts configured
* **[journalnodes]** : configures _journalnode_ services required for HA configuration, at least one host is required in the case 2 **[namenodes]** hosts configured
* **[postgresql]** : configures _postgresql_ server. the server stores any data required for other services( see below ). 1 host is allowed.
* **[hivemetastore]** : configures _hive metastore_ and _hiveserver2_ services. 1 host is allowed. **[postgresql]** host is required for metadata storage.
* **[impala-store-catalog]**: configures _impala-catalog_ and _impala-state-store_ services. 1 host is allowed. _impala-server_ will be configured on each **[datanodes]** host. **[hivemetastore]** host is required for metadata storage.
* **[hbasemaster]**: configures _hbase-master_ services. 1 host is allowed. _hbase-regionserver_ will be configured on on each **[datanodes]** host. at least 1 **[zookeepernodes]** host is requird
* **[hue]**: configures _hue_ and _oozie_ services. 1 host is allowed. **[postgresql]** host is required for configuration data storage.

#### Variables parameters.
Please see [group/vars/all](group_vars/all)

# Usage
To start deployment run:

    ansible-playbook -i hosts site.yaml 

if you have installed clinit you can also run:

    clinit -S workdir/services.xml status
    clinit -S workdir/services.xml tree

#### Tags used in playbook:
* **package** : install rpm packages
* **config** : deploy configuration files, useful if you want just change configuration on hosts.
* **test** : run test actions
* **check** : check hosts configuration

Also most hostgroups have the tag with similar name.

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
