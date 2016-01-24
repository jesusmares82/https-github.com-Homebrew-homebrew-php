class Phplint < Formula
  desc "Validator and documentator for PHP 4 and PHP 5 programs"
  homepage "http://www.icosaedro.it/phplint/"
  url "http://www.icosaedro.it/phplint/phplint-2.1_20151116.tar.gz"
  version "2.1-20151116"
  sha256 "fa2483445b2c7eb693093c12436a49b668deeeea6d18bdb3450980eef5d1ea58"

  bottle do
    cellar :any_skip_relocation
    sha256 "b91313dbf64da53faaf61067430ef41e7c0925d1ecdb7916ab9bc098138fa1f0" => :el_capitan
    sha256 "a7a872b101783508783bed88a0ff042963d81819cf8ee48527e747f4f27d099c" => :yosemite
    sha256 "369ba4b5e325c6ebbcbb8294984c1c680080272a384549fdf11e67d37d8875f5" => :mavericks
  end

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
