Introduction
===========

This cookbook installs the following 3 components:

1.  [Scala][1]
2.  [Spark][2]
3.  [Shark][3]

The Spark master and worker start up scripts are installed as Linux services (*spark-master* and *spark-worker*).  
Shark is installed as a standalone application on both master and worker nodes.  
Scala is, well, a cool programming language.

Many thanks go to [Alex B.][4], who's helped tremendously with putting this cookbook together and making it work.

Requirements
============

For this cookbook to be able to fulfill its purpose, please make sure you meet the requirements in this section.

Available Packages
------------------

This cookbook assumes you have defined a repository available to Chef, and made the following packages available for installation by chef recipes:

* <code>spark</code> version <code>0.9.1-1</code>
* <code>shark</code> same as the Spark version (default is <code>0.9.1-1</code>)
* <code>scala</code> version <code>2.10.4-1</code>

You can build these packages by using the [fpm tool][5]:

* <code>fpm -s tar -t rpm -v 0.9.1 -n spark --prefix /usr/lib --url "http://spark.apache.org/" --description "An open sourceMultiMarkdown cluster computing system that aims to make data analytics fast" --verbose spark-0.9.1-hadoop-cdh4.2.0.tar.gz</code>
* <code>fpm -s tar -t rpm -v 0.9.1 -n shark --prefix /usr/lib --url "http://shark.cs.berkeley.edu/" --description "An open source distributed SQL query engine for Hadoop data" --verbose shark-0.9.1-hadoop-cdh4.2.0.tar.gz</code>
* <code>fpm -s tar -t rpm -v 2.10.4 -n scala --prefix /usr/lib --url "http://www.scala-lang.org/" --description "The Scala programming language" --verbose scala-2.10.4.tgz</code>

Where <code>spark-0.9.1-hadoop-cdh4.2.0.tar.gz</code> and <code>shark-0.9.1-hadoop-cdh4.2.0.tar.gz</code> are gzipped tarball binaries built against hadoop version *cdh4.2.0*. The example above assumes you build rpm packages but you're welcome to replace the 'rpm' part of it with 'deb' or other packaging formats supported by chef & fpm.  

Instructions on how to build the Spark and Shark binaries can be found on their GitHub pages.

Pre-Installed Packages
----------------------

* Jdk 1.7  
 
 This cookbook does not install any Jdk and assumes you have one installed (preferably 1.7) on all target nodes.  
Note that nodes where Shark is planned to be used **MUST** have Jdk 1.7 (wheres Spark only nodes can make do with Java 1.6)

* Hadoop  

  This cookbook assumes you're installing **Spark along side Hadoop** (i.e., you have a local Hadoop installation on each Spark node).

Hive Configuration File (hive-site.xml)
--------------------------------------

This cookbook expects to find a hive configuration file at <code>"#{node[:shark][:home]}/conf/hive-site.xml"</code>,
make sure you have one placed there (for instance by your Hive cookbook, or by extending this one to place a resource).

Required Attributes
-------------------

Before running this cookbook the following attributes (residing in the default recipe) **MUST** be set according to your cluster topology:

* <code>node.normal[:spark][:workers]</code>, an array holding your worker nodes' IP/DNS addresses.
* <code>node.normal[:spark][:master]</code>, you master's IP/DNS address.

Further Notes
=============

* To use this cookbook you need to assign the spark-worker and spark-master recipes to your worker and master nodes, respectively.
* Components' versions can be tweaked using the corresponding attributes, but this will also require building new matching packages.
* It is crucial that your Spark & Shark builds are compiled against the same Hadoop version (that is neither specified nor controlled by this cookbook which, relies on pre-built Spark and Shark packages).


  [1]: http://www.scala-lang.org/
  [2]: http://spark.apache.org/
  [3]: http://shark.cs.berkeley.edu/
  [4]: https://github.com/balexx
  [5]: https://github.com/jordansissel/fpm
