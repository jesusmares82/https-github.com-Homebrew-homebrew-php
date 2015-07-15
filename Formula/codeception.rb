require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Codeception < Formula
  desc "PHP Testing Framework is designed to work just out of the box."
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.1.1/codecept.phar"
  sha256 "c7e8fcfd826be3c4a2b9231deb9fb3bbc570f3ef12376595cd3bb2fbd3932d3f"

  def install
    mv "codecept.phar", "codecept-#{version}.phar"
    libexec.install "codecept-#{version}.phar"
    sh = libexec + "codecept"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/codecept-#{version}.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  def caveats; <<-EOS.undent
    To update your tests for 2.1 check the "Upgrading" section:
    http://codeception.com/06-30-2015/codeception-2.1-is-here.html

    EOS
  end

  test do
    system "codecept", "--version"
  end
end
