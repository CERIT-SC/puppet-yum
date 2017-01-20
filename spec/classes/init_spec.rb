require 'spec_helper'

describe 'yum' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('yum') }

      context 'without any parameters' do
        let(:params) { {} }

        it { is_expected.to contain_yum__config('installonly_limit').with_ensure('5').that_notifies('Exec[package-cleanup_oldkernels]') }
        it { is_expected.to contain_yum__config('keepcache').with_ensure('0') }
        it { is_expected.to contain_yum__config('debuglevel').with_ensure('2') }
        it { is_expected.to contain_yum__config('exactarch').with_ensure('1') }
        it { is_expected.to contain_yum__config('obsoletes').with_ensure('1') }
        it { is_expected.to contain_yum__config('gpgcheck').with_ensure('1') }

        it 'contains Exec[package-cleanup_oldkernels' do
          is_expected.to contain_exec('package-cleanup_oldkernels').with(
            command: '/usr/bin/package-cleanup --oldkernels --count=5 -y',
            refreshonly: true
          ).that_requires('Package[yum-utils]')
        end
      end

      context 'when clean_old_kernels => false' do
        let(:params) { { clean_old_kernels: false } }

        it { is_expected.to contain_yum__config('installonly_limit').without_notify }
      end
    end
  end

  context 'on an unsupported operating system' do
    let(:facts) { { os: { family: 'Solaris', name: 'Nexenta' } } }

    it { is_expected.to raise_error(Puppet::Error, %r{Nexenta not supported}) }
  end
end
