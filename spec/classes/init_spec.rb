require 'spec_helper'

describe 'yum' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }

      context 'without any parameters' do
        let(:params) { {} }

        it { is_expected.to contain_yum__config('installonly_limit').with_ensure('5').that_notifies('Exec[package-cleanup_oldkernels]') }
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
