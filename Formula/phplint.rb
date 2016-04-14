class Phplint < Formula
  desc "Validator and documentator for PHP 5 and 7 programs"
  homepage "http://www.icosaedro.it/phplint/"
  url "http://www.icosaedro.it/phplint/phplint-3.0_20160307.tar.gz"
  version "3.0-20160307"
  sha256 "7a361166d1a6de707e6728828a6002a6de69be886501853344601ab1da922e7b"

  if MacOS.version <= :mavericks
    if Formula["php55"].linked_keg.exist?
      depends_on "php55"
    elsif Formula["php70"].linked_keg.exist?
      depends_on "php70"
    else
      depends_on "php56"
    end
  end

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
