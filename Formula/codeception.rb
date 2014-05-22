require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Codeception < Formula
  homepage 'http://codeception.com/quickstart'
  url 'http://codeception.com/releases/1.8.5/codecept.phar'
  sha1 'c0e9ebe64f1b5fb9edc3c82d074880ec2abf0a13'

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
