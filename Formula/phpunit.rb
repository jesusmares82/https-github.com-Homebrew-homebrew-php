require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Phpunit < Formula
  homepage "http://phpunit.de"
  url "https://phar.phpunit.de/phpunit-4.7.6.phar"
  sha256 "f97a77f09773dd963e8eb5d36ef541f62039b603cfcb452691d27c423499569d"

  bottle do
    cellar :any
    sha256 "9c040894f1116e3edc29e279a6040c16d1c6fbd35527e0a88b22d6cfe3f8855a" => :yosemite
    sha256 "a0115e84ac47de8f70cfe87be14461fd7bbba514800b9139757f98b4f487053f" => :mavericks
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

