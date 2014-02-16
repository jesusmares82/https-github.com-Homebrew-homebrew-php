require 'formula'

class Phpunit < Formula
  homepage 'http://phpunit.de/manual/current/en/'
  url 'https://github.com/sebastianbergmann/phpunit/releases/download/3.7.30/phpunit.phar'
  sha1 'b3215880ddcd888f2117554bd101818139b4bd96'
  version '3.7.30'

  def install
    mv "phpunit.phar", "phpunit-#{version}.phar"
    libexec.install "phpunit-#{version}.phar"
    sh = libexec + "phpunit"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/phpunit-#{version}.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

end
