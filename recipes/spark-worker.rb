include_recipe 'spark-shark-cookbook::default'

service 'spark-worker' do
  action :start
end
