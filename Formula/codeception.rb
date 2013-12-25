require 'formula'

class Codeception < Formula
  homepage 'http://codeception.com/quickstart'
  url 'http://codeception.com/releases/1.8.1/codecept.phar'
  sha1 '3541b1366d6fd35cd45505566da5f41016e8b579'

  def install
    mv "codecept.phar", "codecept-#{version}.phar"
    libexec.install "codecept-#{version}.phar"
    sh = libexec + "codecept"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/codecept-#{version}.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  test do
    `system "codecept", "--version"`
  end
end
