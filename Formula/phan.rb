require File.expand_path("../../language/php", __FILE__)

class Phan < Formula
  include Language::PHP::Composer

  desc "Static analyzer for PHP"
  homepage "https://github.com/etsy/phan"
  url "https://github.com/etsy/phan/archive/0.2.tar.gz"
  sha256 "fe3871aa96fae79323a635e6ca34f129bf2176ebf2664e81f1be7056841c3b01"
  head "https://github.com/etsy/phan.git"

  bottle do
  end

  depends_on "php70-ast"
  depends_on "php70"

  def install
    composer_install
    prefix.install Dir["*"]
    bin.install_symlink prefix/"phan"
  end

  test do
    system "phan", "--version"
  end
end
