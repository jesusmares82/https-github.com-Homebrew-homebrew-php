require 'formula'

class Phpunit < Formula
  homepage 'http://phpunit.de/manual/current/en/'
  url 'https://phar.phpunit.de/phpunit-4.0.7.phar'
  sha1 '38951386355ed099650b323a7a1c9621ddc07b26'

  def install
    libexec.install "phpunit-#{version}.phar"
    sh = libexec + "phpunit"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/phpunit-#{version}.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end
end
