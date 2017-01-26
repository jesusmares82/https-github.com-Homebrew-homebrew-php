require File.expand_path("../../language/php", __FILE__)

class Phan < Formula
  include Language::PHP::Composer

  desc "Static analyzer for PHP"
  homepage "https://github.com/etsy/phan"
  url "https://github.com/etsy/phan/archive/0.8.3.tar.gz"
  sha256 "3fde034a755b37af3270a9f3d30e01ef29558cb622c028c7f8380d98d5e733ae"
  head "https://github.com/etsy/phan.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "11c8cf920dc99a0862e0c3c58e9dafdbefeaedf9960f04c2c3a3e43e6fa3c3a7" => :sierra
    sha256 "3c5ce19d3537355a59d5f1021daefa25f36f2e31b92c8d1ec24e709af757f54e" => :el_capitan
    sha256 "f6645cac827429fa7ccbda4b2992629de08c62bc46493b5fec6c6403118b5c4c" => :yosemite
  end

  depends_on "php70-ast"
  depends_on "php70"

  def install
    composer_install
    prefix.install Dir["*"]
    bin.install_symlink prefix/"phan"
  end

  test do
    system "#{bin}/phan", "-h"
  end
end
