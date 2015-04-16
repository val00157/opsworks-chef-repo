#
# Cookbook Name:: yum_repo
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

bash 'add_elasticsearch' do
  user 'root'
  code <<-EOC
    rpm --import https://packages.elasticsearch.org/GPG-KEY-elasticsearch
  EOC
  creates "/etc/yum.repos.d/elasticsearch.repo"
end
cookbook_file "/etc/yum.repos.d/elasticsearch.repo" do
  source "elasticsearch.repo"
end

