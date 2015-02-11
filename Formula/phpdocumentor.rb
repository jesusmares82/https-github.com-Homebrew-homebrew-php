require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Phpdocumentor < Formula
  homepage 'http://www.phpdoc.org'
  url 'https://github.com/phpDocumentor/phpDocumentor2/releases/download/v2.8.1/phpDocumentor.phar'
  sha1 'f3fe8784ac4d72428da12303ab7199419da4cb80'
  version '2.8.1'

  depends_on PhpMetaRequirement
  depends_on PharRequirement

  def install
    libexec.install "phpDocumentor.phar"
    sh = libexec + "phpdoc"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/phpDocumentor.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  def caveats; <<-EOS.undent
    Verify your installation by running:
      "phpdoc --version".

    You can read more about phpdocumentor by running:
      "brew home phpdocumentor".
    EOS
  end

end
