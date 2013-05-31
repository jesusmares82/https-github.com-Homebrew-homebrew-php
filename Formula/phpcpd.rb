require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", Pathname.new(__FILE__).realpath)
require File.expand_path("../../Requirements/phar-requirement", Pathname.new(__FILE__).realpath)

class Phpcpd < Formula
  homepage 'https://github.com/sebastianbergmann/phpcpd'
  url 'http://pear.phpunit.de/get/phpcpd.phar'
  sha1 '86d59e472a424ab41bb657d41b77dc01a4868dc7'
  version '1.4.0'

  depends_on PhpMetaRequirement
  depends_on PharRequirement

  def install
    libexec.install "phpcpd.phar"
    sh = libexec + "phpcpd"
    sh.write("#!/bin/sh\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/phpcpd.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  def test
    system 'phpcpd --version'
  end

  def caveats; <<-EOS.undent
    Verify your installation by running:
      "phpcpd --version".

    You can read more about phpcpd by running:
      "brew home phpcpd".
    EOS
  end
end
