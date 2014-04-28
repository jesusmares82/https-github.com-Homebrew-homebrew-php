require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Phpmd < Formula
  homepage 'http://phpmd.org'
  url 'http://static.phpmd.org/php/1.5.0/phpmd.phar'
  sha1 '4e64bd506afad7e9aa1b0c1f4216660395e347ac'

  depends_on PhpMetaRequirement
  depends_on PharRequirement

  def install
    libexec.install "phpmd.phar"
    sh = libexec + "phpmd"
    sh.write("#!/bin/sh\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/phpmd.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  def test
    system 'phpmd'
  end

  def caveats; <<-EOS.undent
    You can read more about phpmd by running:
      "brew home phpmd".
    EOS
  end
end
