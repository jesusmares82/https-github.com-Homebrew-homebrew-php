require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Codeception < Formula
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.0.13/codecept.phar"
  sha256 "9a7ca6750c2bdf83e092304cb158f13d4c676d7f74b4b88adb78132c4a41fa58"
  version "2.0.13"

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
