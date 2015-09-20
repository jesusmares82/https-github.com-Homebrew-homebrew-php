require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class PhpunitSkeletonGenerator < Formula
  desc "Generate skeleton test classes"
  homepage "http://phpunit.de/manual/current/en/"
  url "https://phar.phpunit.de/phpunit-skelgen-1.2.1.phar"
  sha256 "b607e122665e9032456185ea870bc96ca0aee839f4ef1447adf190225e24fc96"

  bottle do
    cellar :any_skip_relocation
    sha256 "1ed95cb8a92f486f6dcaf6b5e2c81f23ab5c003823550831297cf62712f3969c" => :el_capitan
    sha256 "3c3caa5b9d28b44188cdccad88cf722a97fdf84d657bd88b6c9c16ca79cfc480" => :yosemite
    sha256 "2f70dcb0ea0d87b940b757a8b5488c2de2dea3dadae687dfbc92930972f4ab35" => :mavericks
  end

  def install
    libexec.install "phpunit-skelgen-#{version}.phar"
    sh = libexec + "phpunit-skelgen"
    sh.write("#!/usr/bin/env bash\n\n/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/phpunit-skelgen-#{version}.phar $*")
    chmod 0755, sh
    bin.install_symlink sh
  end

  test do
    system "phpunit-skelgen", "--version"
  end
end
