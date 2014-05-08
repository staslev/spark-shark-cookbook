package 'shark' do
  action :install
  version "#{node[:spark][:version]}"
end

template "#{node[:shark][:home]}/conf/shark-env.sh" do
  source 'shark-env.sh.erb'
  owner node[:spark][:username]
  group node[:spark][:group]
  mode 00600
end

# Make sure you have one of these, see the readme.md for more details
# template "#{node[:shark][:home]}/conf/hive-site.xml" do
#   source 'hive-site.xml.erb'
#   owner node[:spark][:username]
#   group node[:spark][:group]
#   mode 00600
# end