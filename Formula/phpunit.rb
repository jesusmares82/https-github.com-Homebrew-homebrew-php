require 'formula'

class Phpunit < Formula
  homepage 'http://phpunit.de/manual/current/en/'
  url 'http://pear.phpunit.de/get/phpunit.phar'
  sha1 'e3644434a01dab6292b0d2319cc52e85a08ce807'
  version '3.7.21'

  def install
    libexec.install "phpunit.phar"
    sh = libexec + "phpunit"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/phpunit.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

end
