include_recipe 'spark-shark-cookbook::default'

service 'spark-master' do
  action :start
end
