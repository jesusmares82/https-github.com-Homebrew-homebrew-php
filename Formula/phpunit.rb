require 'formula'

class Phpunit < Formula
  homepage 'http://phpunit.de/manual/current/en/'
  url 'http://pear.phpunit.de/get/phpunit-3.7.22.phar'
  sha1 '88d4919ffc91c9aec8aea2b28e500d3e43e2b13b'
  version '3.7.22'

  def install
    libexec.install "phpunit.phar"
    sh = libexec + "phpunit"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/phpunit.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

end
