require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class PhpunitSkeletonGenerator < Formula
  homepage 'http://phpunit.de/manual/current/en/'
  url 'https://phar.phpunit.de/phpunit-skelgen-1.2.1.phar'
  sha1 '104c4f0a88ad5cbcc1ab18c449fffc22a56344f6'

  def install
    libexec.install "phpunit-skelgen-#{version}.phar"
    sh = libexec + "phpunit-skelgen"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/phpunit-skelgen-#{version}.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end
end
