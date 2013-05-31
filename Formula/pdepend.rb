require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", Pathname.new(__FILE__).realpath)
require File.expand_path("../../Requirements/phar-requirement", Pathname.new(__FILE__).realpath)

class Pdepend < Formula
  homepage 'http://pdepend.org/'
  url 'http://static.pdepend.org/php/latest/pdepend.phar'
  sha1 'd91fb76e03160bbe957078e95cbf88cb47cdf132'
  version '1.1.0'

  depends_on PhpMetaRequirement
  depends_on PharRequirement

  def install
    libexec.install "pdepend.phar"
    sh = libexec + "pdepend"
    sh.write("#!/bin/sh\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/pdepend.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  def test
    system 'pdepend --version'
  end

  def caveats; <<-EOS.undent
    Verify your installation by running:
      "pdepend --version".

    You can read more about pdepend by running:
      "brew home pdepend".
    EOS
  end
end
