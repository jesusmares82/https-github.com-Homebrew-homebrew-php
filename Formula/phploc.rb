require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Phploc < Formula
  homepage 'https://github.com/sebastianbergmann/phploc'
  url 'https://phar.phpunit.de/phploc-2.0.2.phar'
  sha1 'e05183e34512dc62d3d79f1760d1927beeab1167'

  depends_on PhpMetaRequirement
  depends_on PharRequirement

  def install
    libexec.install "phploc-#{version}.phar"
    sh = libexec + "phploc"
    sh.write("#!/bin/sh\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/phploc-#{version}.phar $*")
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
