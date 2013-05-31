require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", Pathname.new(__FILE__).realpath)
require File.expand_path("../../Requirements/phar-requirement", Pathname.new(__FILE__).realpath)

class PhpMd < Formula
  homepage 'http://phpmd.org/'
  url 'http://static.phpmd.org/php/1.4.1/phpmd.phar'
  sha1 '84ea7e1a2df395f13bf54ebeb1c23474a1ce6b9d'
  version '1.4.1'

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
    system 'phpmd --version'
  end

  def caveats; <<-EOS.undent
    Verify your installation by running:
      "phpmd --version".

    You can read more about phpmd by running:
      "brew home phpmd".
    EOS
  end
end
