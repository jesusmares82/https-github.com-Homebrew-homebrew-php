require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", Pathname.new(__FILE__).realpath)
require File.expand_path("../../Requirements/composer-requirement", Pathname.new(__FILE__).realpath)

class Composer < Formula
  homepage 'http://getcomposer.org'
  url 'http://getcomposer.org/download/1.0.0-alpha6/composer.phar'
  sha1 'f01c2bbbd5d9d56fe7b2250081d66c40dbe9a3e6'
  version '1.0.0-alpha6'

  depends_on PhpMetaRequirement.new
  depends_on ComposerRequirement.new

  def install
    libexec.install "composer.phar"
    sh = libexec + "composer"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/composer.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  def caveats; <<-EOS.undent
    Verify your installation by running:
      "composer --version".

    You can read more about composer and packagist by running:
      "brew home composer".
    EOS
  end

end
