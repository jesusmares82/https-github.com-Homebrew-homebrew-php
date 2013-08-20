require 'formula'

class Phpunit < Formula
  homepage 'http://phpunit.de/manual/current/en/'
  url 'http://pear.phpunit.de/get/phpunit-3.7.24.phar'
  sha1 'de677ba60b2ccd135002d02501cde16a471503f5'

  def install
    libexec.install "phpunit-#{version}.phar"
    sh = libexec + "phpunit"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/phpunit-#{version}.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

end
