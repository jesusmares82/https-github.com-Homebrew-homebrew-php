require File.expand_path("../../language/php", __FILE__)

class PhanAT08 < Formula
  include Language::PHP::Composer

  desc "Static analyzer for PHP"
  homepage "https://github.com/etsy/phan"
  url "https://github.com/etsy/phan/archive/0.8.4.tar.gz"
  sha256 "b32c40c0edbd54fdd48d411f6a68a368983f8c9429aae98fba41e68ffe7efde0"
  head "https://github.com/etsy/phan.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "7c684f36976ec0fbe0252d824d2274127ffaf84470d4742634c1427583ddd2c6" => :sierra
    sha256 "9865b3cb0c444223c46a1a6f9586aeef751e8b8716fcf874e236835a396efd33" => :el_capitan
    sha256 "7e2d11ed186bd8142e9bbc69030d12e1ab62482d5511207862d251528197c7f6" => :yosemite
  end

  depends_on "php70-ast"
  depends_on "php70"

  def install
    composer_install
    prefix.install Dir["*"]
    bin.install_symlink prefix/"phan"
  end

  test do
    system "#{bin}/phan", "--help"
  end
end
