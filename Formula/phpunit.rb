require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)
require File.expand_path("../../Requirements/phar-requirement", __FILE__)

class Phpunit < Formula
  desc "PHPUnit is a programmer-oriented testing framework for PHP."
  homepage "http://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.0.0.phar"
  sha256 "f1d59163ceefd69f5969fb098d03c0adb07507a56f3bafd3cf4614bac93e457c"

  devel do
	url "https://phar.phpunit.de/phpunit-beta.phar"
	sha256 "977b3790fe712db1eb7cc04c554edfe5b6a4dc162143cd616c196fbbf6f7caeb"
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "2b879fa474a2b7bab2ae4ec4fff2c4a346eb5735d46c6b11922772ec9ae5ad26" => :el_capitan
    sha256 "e572f4871132979e977ab5789bda6942fee72def31ff0fd425d1c426a3795d1b" => :yosemite
    sha256 "d08b2316a4b99bf510c8b2f9dbd60186b3ed435442c90ee5a51f4d7661afd85f" => :mavericks
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
