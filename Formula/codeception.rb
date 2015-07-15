require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Codeception < Formula
  desc "PHP Testing Framework is designed to work just out of the box."
  homepage "http://codeception.com/quickstart"
  url "http://codeception.com/releases/2.1.1/codecept.phar"
  sha256 "c7e8fcfd826be3c4a2b9231deb9fb3bbc570f3ef12376595cd3bb2fbd3932d3f"

  bottle do
    cellar :any
    sha256 "c20db42c395ef970d01fdf9c7116677836eed8b3574c90c36548a25713da1420" => :yosemite
    sha256 "0e00ff7d04cb70a82d605b170467a99d034b057f9f6be9a390b9eca16f7513cc" => :mavericks
    sha256 "23d73fca1b4c506da568d8342a9c593922d4118f76a20b04695e74cab353a705" => :mountain_lion
  end

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
