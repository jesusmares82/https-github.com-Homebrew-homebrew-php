require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/composer-requirement", __FILE__)

class Composer < Formula
  homepage 'http://getcomposer.org'
  url 'http://getcomposer.org/download/1.0.0-alpha8/composer.phar'
  sha1 '6eefa41101a2d1a424c3d231a1f202dfe6f09cf8'
  version '1.0.0-alpha8'

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
