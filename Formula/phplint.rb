class Phplint < Formula
  desc "PHPLint is a validator and documentator for PHP 4 and PHP 5 programs"
  homepage "http://www.icosaedro.it/phplint/"
  url "http://www.icosaedro.it/phplint/phplint-2.1_20150305.tar.gz"
  version "2.1-20150305"
  sha256 "cfa2c1b9ffcb0c60ec6fec164f249d5e608ebba1154ba6bd77ac331b03615e42"

  def install
    inreplace "php", "/opt/php/bin/php", "/usr/bin/env php"
    inreplace "phpl", "$__DIR__/", "$__DIR__/../"
    inreplace "phplint.tcl", "\"MISSING_PHP_CLI_EXECUTABLE\"", "#{prefix}/php"
    inreplace "phplint.tcl", "set opts(phplint_dir) [pwd]", "set opts(phplint_dir) #{prefix}"

    prefix.install "modules"
    prefix.install "stdlib"
    prefix.install "utils"
    prefix.install "php"

    bin.install "phpl"
    bin.install "phplint.tcl"
  end

  test do
    system "phpl", "--version"
  end
end
