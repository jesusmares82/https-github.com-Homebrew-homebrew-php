require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Pdepend < Formula
  homepage 'http://pdepend.org/'
  url 'http://static.pdepend.org/php/1.1.3/pdepend.phar'
  sha1 '8f218621ac3ec3137fcef6e95e804787be91253d'

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
