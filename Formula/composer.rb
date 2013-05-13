require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", Pathname.new(__FILE__).realpath)
require File.expand_path("../../Requirements/composer-requirement", Pathname.new(__FILE__).realpath)

class Composer < Formula
  homepage 'http://getcomposer.org'
  url 'http://getcomposer.org/download/1.0.0-alpha7/composer.phar'
  sha1 '4f8513bea6daa4f70007e4344944c2fe458650ac'
  version '1.0.0-alpha7'

  depends_on PhpMetaRequirement
  depends_on ComposerRequirement

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
