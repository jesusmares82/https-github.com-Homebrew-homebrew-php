require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Climb < AbstractPhpPhar
  init
  desc "Composer version manager tool"
  homepage "https://github.com/vinkla/climb"
  url "https://github.com/vinkla/climb/releases/download/0.8.1/climb.phar"
  sha256 "0778330f793cc1cf0fc4e443c10f2d65c2160aa1e731102b5f07187d3373686e"

  bottle do
    cellar :any_skip_relocation
    sha256 "d49bbefcf4feb90673f3c0dd5c781b31d51b1043434269d53b5fd859730163e0" => :el_capitan
    sha256 "6d48427d4674d07bf3fa290dcde0e802f0dc4e4ab10d7758ae02fc3e3cd64640" => :yosemite
    sha256 "647f1ffec530e41d101910695379d2a97fc8c555f84a32be9afebd18d53baa32" => :mavericks
  end

  test do
    system "climb", "--version"
  end
end
