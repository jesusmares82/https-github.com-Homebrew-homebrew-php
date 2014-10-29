require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Phpdox < Formula
  homepage 'https://github.com/theseer/phpdox'
  url 'http://phpdox.de/releases/phpdox-0.7.0.phar'
  sha1 'e8b3f31de7cde804c6f5eede69b0d210eafc7aac'

  depends_on PhpMetaRequirement
  depends_on PharRequirement

  def install
    libexec.install "phpdox-#{version}.phar"
    sh = libexec + "phpdox"
    sh.write("#!/bin/sh\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/phpdox-#{version}.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  test do
    system 'phpdox --version'
  end

  def caveats; <<-EOS.undent
    Verify your installation by running:
      "phpdox --version".

    You can read more about phpdox by running:
      "brew home phpdox".
    EOS
  end
end
