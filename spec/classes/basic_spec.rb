require 'spec_helper'

describe 'yum' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context 'yum class without any parameters' do
          it { is_expected.to compile.with_all_deps }

          it do
            is_expected.to contain_yum__config('installonly_limit').with(
              ensure: '5',
              notify: 'Exec[package-cleanup_oldkernels]'
            )
          end
        end

        context 'clean_old_kernels => false' do
          let(:params) { { clean_old_kernels: false } }
          it { is_expected.to contain_yum__config('installonly_limit').without_notify }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'yum class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          os: {
            family: 'Solaris',
            name:   'Nexenta'
          }
        }
      end

      it { is_expected.to raise_error(Puppet::Error, %r{Nexenta not supported}) }
    end
  end
end
