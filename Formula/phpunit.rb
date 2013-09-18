require 'formula'

class Phpunit < Formula
  homepage 'http://phpunit.de/manual/current/en/'
  url 'https://github.com/sebastianbergmann/phpunit/releases/download/3.7.27/phpunit.phar'
  sha1 'dc693b34a62644f61cfc01a22d9654ff4b8764af'
  version '3.7.27'

  def install
    mv "phpunit.phar", "phpunit-#{version}.phar"
    libexec.install "phpunit-#{version}.phar"
    sh = libexec + "phpunit"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/phpunit-#{version}.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

end
