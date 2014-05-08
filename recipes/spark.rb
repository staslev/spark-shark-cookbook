node.normal[:spark][:workers] = REPLACE-WITH-YOUR-WORKER-NODES-ADDRESSES
node.normal[:spark][:master] = REPLACE-WITH-YOUR-MASTER-NODE-ADDRESSES
node.normal[:spark][:master_uri] = "spark://#{node[:spark][:master]}:#{node[:spark][:master_port]}"

package 'scala' do
  action :install
  version "#{node[:scala][:version]}"
end

package "spark" do
  action :install
  version "#{node[:spark][:version]}"
end

template "#{node[:spark][:home]}/conf/spark-env.sh" do
  source 'spark-env.sh.erb'
  owner node[:spark][:username]
  group node[:spark][:group]
  mode 00600
end

template "#{node[:spark][:home]}/conf/slaves" do
  source 'slaves.erb'
  owner node[:spark][:username]
  group node[:spark][:group]
  mode 00600
end

template '/etc/init.d/spark-master' do
  source 'spark.master.initd.erb'
  owner 'root'
  group 'root'
  mode 00744
end

template '/etc/init.d/spark-worker' do
  source 'spark.worker.initd.erb'
  owner 'root'
  group 'root'
  mode 00744
end
