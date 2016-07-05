facts_cache_dir = '/var/cache/puppet/facts.d'
yum_cache_file = File.join(facts_cache_dir,'yum.state')
yumsec_cache_file = File.join(facts_cache_dir,'yumsec.state')
facts_cache_ttl = 86400 # 1d

yum_package_updates = nil
Facter.add("yum_has_updates") do
  confine :osfamily => 'RedHat'
  if File.executable?("/bin/yum") or File.executable?("/usr/bin/yum")
    if not File::exist?(facts_cache_dir) then
        FileUtils::mkdir_p facts_cache_dir
    end
    if File::exist?(yum_cache_file) then
        cache_time = File.mtime(yum_cache_file)
    end

    # Retrieve new data if local cache exceeds TTL
    if not File::exist?(yum_cache_file) or (Time.now - cache_time) > facts_cache_ttl then
        myrun = `yum -q check-update > #{yum_cache_file} 2>/dev/null`
    end

    yum_check_result = File.read(yum_cache_file).split("\n").reject { |c| c.empty? }.size
    if not yum_check_result.nil? and yum_check_result.to_s =~ /^\d+$/
      yum_package_updates = yum_check_result
    end
  end

  setcode do
    if not yum_package_updates.nil?
      yum_package_updates != '0'
    end
  end
end

Facter.add("yum_package_updates") do
  confine :yum_has_updates => true
  setcode do
    packages = File.read(yum_cache_file).gsub(/\ +/, ' ').split("\n").reject { |c| c.empty? }
    if Facter.version < '2.0.0'
      packages.join(',')
    else
      packages
    end
  end
end

Facter.add("yum_updates") do
  confine :yum_has_updates => true
  setcode do
    Integer(yum_package_updates[0])
  end
end

Facter.add("yum_security_updates") do
  confine :yum_has_updates => true
  confine :operatingsystem => 'RedHat'
  setcode do
    if File::exist?(yumsec_cache_file) then
        cache_time = File.mtime(yumsec_cache_file)
    end

    # Retrieve new data if local cache exceeds TTL
    if not File::exist?(yumsec_cache_file) or (Time.now - cache_time) > facts_cache_ttl then
        myrun = `yum -q --security check-update > #{yumsec_cache_file} 2>/dev/null`
    end

    yumsec_check_result = File.read(yumsec_cache_file).split("\n").reject { |c| c.empty? }.size
    if not yumsec_check_result.nil? and yumsec_check_result.to_s =~ /^\d+$/
      yumsec_package_updates = yumsec_check_result
    end
    Integer(yumsec_package_updates)
  end
end

