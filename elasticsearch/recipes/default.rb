#
# Cookbook Name:: elasticsearch
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
stack = node[:opsworks][:stack][:name] 
params = data_bag_item("elasticsearch", stack)["elasticsearch"]

# パッケージインストール
package "elasticsearch" do
  action :install
end

# 設定ファイルの展開
template "/etc/elasticsearch/elasticsearch.yml" do
  source "elasticsearch.yml.erb"
  variables(
      :params => params
  )
end

# サービス登録を行なって開始する。
service "elasticsearch" do
  supports :status => true, :restart => true
  action [:enable, :restart]
end

