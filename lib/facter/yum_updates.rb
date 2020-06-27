Facter.add('yum_package_updates') do
  confine osfamily: 'RedHat'
  setcode do
    yum_updates = []

    if File.executable?('/usr/bin/yum')
      yum_get_result = Facter::Util::Resolution.exec('/usr/bin/yum --assumeyes --quiet --cacheonly list updates')
      unless yum_get_result.nil?
        yum_get_result.each_line do |line|
          %r{\A(?<package>\S+\.\S+)\s+(?<available_version>[[:digit:]]\S+)\s+(?<repository>\S+)\s*\z} =~ line
          if package && available_version && repository
            yum_updates.push(package)
          end
        end
      end
    end

    yum_updates
  end
end

Facter.add('yum_has_updates') do
  confine osfamily: 'RedHat'
  setcode do
    Facter.value(:yum_package_updates).any?
  end
end

Facter.add('yum_updates') do
  confine osfamily: 'RedHat'
  setcode do
    Facter.value(:yum_package_updates).length
  end
end
