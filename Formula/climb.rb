require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Climb < AbstractPhpPhar
  init
  desc "Composer version manager tool"
  homepage "https://github.com/vinkla/climb"
  url "https://github.com/vinkla/climb/releases/download/0.6.1/climb.phar"
  sha256 "f5e3711149a321ec35ed71740baa128e7021dd56bde06b971a3ed3cdcfe6bc63"

  bottle do
    cellar :any_skip_relocation
    sha256 "b159c718965448d740a3740f61d3de5d083889ae7d3cf1484643b14b1f05589c" => :el_capitan
    sha256 "6db44dc55fa2c80f614498f3dd377bd456fd63cf364b960303b1a668911d5294" => :yosemite
    sha256 "1023382503968cbc7591c67cc9107134ae5d0a6e1b5599a7f601e9c3e48f11ca" => :mavericks
  end

  test do
    system "climb", "--version"
  end
end
