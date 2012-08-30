machine =  node[:kernel][:machine]
libpq_deb_path = File.join(node[:deployment][:setup_cache], "libpq5_9.2.deb")
cf_remote_file libpq_deb_path do
  owner node[:deployment][:user]
  id node[:postgresql][:id][:libpq]["#{machine}"]
  checksum node[:postgresql][:checksum][:libpq]["#{machine}"]
end

libpq_dev_deb_path = File.join(node[:deployment][:setup_cache], "libpq-dev_9.2.deb")
cf_remote_file libpq_dev_deb_path do
  owner node[:deployment][:user]
  id node[:postgresql][:id][:libpq_dev]["#{machine}"]
  checksum node[:postgresql][:checksum][:libpq_dev]["#{machine}"]
end

bash "Install libpq" do
  code <<-EOH
  dpkg -i #{libpq_deb_path}
  EOH
end

bash "Install libpq-dev" do
  code <<-EOH
  dpkg -i #{libpq_dev_deb_path}
  EOH
end
