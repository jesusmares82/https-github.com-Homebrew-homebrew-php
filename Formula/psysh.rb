require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Psysh < Formula
  include Language::PHP::Composer

  desc "Runtime developer console, interactive debugger & REPL"
  homepage "https://github.com/bobthecow/psysh"
  url "https://github.com/bobthecow/psysh/archive/v0.8.5.tar.gz"
  sha256 "d836c661b6d0b6a8b88458c715bb415cec1714cb5d8703f67573c0de6745b98c"
  head "https://github.com/bobthecow/psysh.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "aa250ae2f2637aa999d33013b2d9ea400dec816a1904a92d814259978540c7dd" => :sierra
    sha256 "438c595ba16f2bf7b414f64f515834d1e32b0fbce93fa7ce9eacff4e56e0f80e" => :el_capitan
    sha256 "7139b6271101dd5f2ee84a81f3d55e664e4b1ec262d2e9defb92b66fa7b9c23e" => :yosemite
  end

  depends_on PhpMetaRequirement

  def install
    composer_install "--no-dev"
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/psysh"
  end

  test do
    system "#{bin}/psysh", "--version"
  end
end
