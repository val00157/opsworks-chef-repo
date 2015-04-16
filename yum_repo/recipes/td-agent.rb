#
# Cookbook Name:: yum_repo
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

bash 'add_td-agent' do
  user 'root'
  code <<-EOC
    rpm --import http://packages.treasuredata.com/GPG-KEY-td-agent
  EOC
  creates "/etc/yum.repos.d/td-agent.repo"
end
cookbook_file "/etc/yum.repos.d/td-agent.repo" do
  source "td-agent.repo"
end

