require 'formula'

class Codeception < Formula
  homepage 'http://codeception.com/quickstart'
  url 'https://github.com/Codeception/Codeception/raw/1.8/package/codecept.phar'
  sha1 '75b69ad9eef41881fa64b59703bf6a8db877e56b'
  version '1.8.0'

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
