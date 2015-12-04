class Phan < Formula
  desc "Static analyzer for PHP"
  homepage "https://github.com/etsy/phan"
  url "https://github.com/etsy/phan/archive/0.1.tar.gz"
  sha256 "e88804430a11f3109ad9756d2997633333b656faf1cf28574aa9d55730cf5848"
  head "https://github.com/etsy/phan.git"

  bottle do
  end

  depends_on "composer"
  depends_on "php70-ast"

  def install
    system "composer", "install"
    prefix.install Dir["*"]
    bin.install_symlink prefix/"phan"
  end

  test do
    system "phan", "--version"
  end
end
