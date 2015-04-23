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

# ディスク容量モニタリングシェルを展開する
template "/root/monitor-disk-usage.sh" do
  source "monitor-disk-usage.sh.erb"
  variables(
      :params => params
  )
  mode 775
end

# ディスク容量モニタリングシェルをcron登録する
cron "Monitor Disk Usage" do
  user "root"
  minute "*/5"
  command "/root/monitor-disk-usage.sh " + (params["MONITORING_MOUNT_DIRECTORY"].nil? ? "" : params["MONITORING_MOUNT_DIRECTORY"])
end
