require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Phpunit < Formula
  homepage "http://phpunit.de"
  url "https://phar.phpunit.de/phpunit-4.7.6.phar"
  sha256 "f97a77f09773dd963e8eb5d36ef541f62039b603cfcb452691d27c423499569d"

  bottle do
  end

  def install
    libexec.install "phpunit-#{version}.phar"
    sh = libexec + "phpunit"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/phpunit-#{version}.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  test do
    shell_output("phpunit --version").include?(version)
  end
end
