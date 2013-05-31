require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", Pathname.new(__FILE__).realpath)
require File.expand_path("../../Requirements/phar-requirement", Pathname.new(__FILE__).realpath)

class Phploc < Formula
  homepage 'https://github.com/sebastianbergmann/phploc'
  url 'http://pear.phpunit.de/get/phploc.phar'
  sha1 'cb91ecab64886637e627a7e3bfbe114e5be56df8'
  version '1.7.4'

  depends_on PhpMetaRequirement
  depends_on PharRequirement

  def install
    libexec.install "phploc.phar"
    sh = libexec + "phploc"
    sh.write("#!/bin/sh\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/phploc.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  def test
    system 'phploc --version'
  end

  def caveats; <<-EOS.undent
    Verify your installation by running:
      "phploc --version".

    You can read more about phploc by running:
      "brew home phploc".
    EOS
  end
end
