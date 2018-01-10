require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpdox < AbstractPhpPhar
  init
  desc "Documentation generator for PHP"
  homepage "https://github.com/theseer/phpdox"
  url "https://github.com/theseer/phpdox/releases/download/0.11.0/phpdox-0.11.0.phar"
  sha256 "32323c75e3ba70f64b2e8ba4df1ddb163407c87de75ae33d558f83bf1615285e"

  bottle do
    cellar :any_skip_relocation
    sha256 "dcd72252329a41bbde97bd67318bab8bde3fcf3d055ec9c3f7dc190c0b980674" => :sierra
    sha256 "a8446ba415a1eb4f0bba0dde4f3295f03aa7d139a806a1f53da379f02bed0d7b" => :el_capitan
    sha256 "a8446ba415a1eb4f0bba0dde4f3295f03aa7d139a806a1f53da379f02bed0d7b" => :yosemite
  end

  def phar_file
    "phpdox-#{version}.phar"
  end

  test do
    system "#{bin}/phpdox", "--version"
  end
end
