package 'java-1.8.0-openjdk-devel' do
  action :install
end
bash "alternatives java" do
  user "root"
  
  EOH
end



