#
# Cookbook Name:: td-agent
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# td-agentインストール
package "td-agent" do
  action :install
end

# elasticsearchプラグインのインストール
gem_package "fluent-plugin-forest" do
  gem_binary "/opt/td-agent/embedded/bin/fluent-gem"
  action :install
end

