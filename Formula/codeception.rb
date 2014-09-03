require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Codeception < Formula
  homepage 'http://codeception.com/quickstart'
  url 'http://codeception.com/releases/2.0.5/codecept.phar'
  sha1 '3ab90ea9299d2649e2e612e810f5bbc9444c3c36'

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
