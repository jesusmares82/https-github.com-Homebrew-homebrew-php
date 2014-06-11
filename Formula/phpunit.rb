require 'formula'
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Phpunit < Formula
  homepage 'http://phpunit.de/manual/current/en/'
  url 'https://phar.phpunit.de/phpunit-4.1.3.phar'
  sha1 '3975a93e0b3bdc0a7b61be2f36f50ee5c7d26c1d'

  def install
    libexec.install "phpunit-#{version}.phar"
    sh = libexec + "phpunit"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/phpunit-#{version}.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end
end
