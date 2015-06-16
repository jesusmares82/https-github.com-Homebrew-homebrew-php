class Phplint < Formula
  desc "PHPLint is a validator and documentator for PHP 4 and PHP 5 programs"
  homepage "http://www.icosaedro.it/phplint/"
  url "http://www.icosaedro.it/phplint/phplint-2.1_20150305.tar.gz"
  version "2.1-20150305"
  sha256 "cfa2c1b9ffcb0c60ec6fec164f249d5e608ebba1154ba6bd77ac331b03615e42"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    cellar :any
    sha256 "67298e41214575875a831c95c7aab57037581b99801b86db67585615aecec9d5" => :yosemite
    sha256 "f044f50fb5e910437633e75777e01b32cf8be88a9aa8e9513b58e92da9bad548" => :mavericks
    sha256 "29803ebfec233cea8db230aad5478e8aa8116333c966ed0f271eeb8d9a0cb261" => :mountain_lion
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
