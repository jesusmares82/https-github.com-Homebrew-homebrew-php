require File.expand_path("../../language/php", __FILE__)

class Phan < Formula
  include Language::PHP::Composer

  desc "Static analyzer for PHP"
  homepage "https://github.com/etsy/phan"
  url "https://github.com/etsy/phan/archive/0.2.tar.gz"
  sha256 "fe3871aa96fae79323a635e6ca34f129bf2176ebf2664e81f1be7056841c3b01"
  head "https://github.com/etsy/phan.git"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "e6403de5743128cc637fab1c97ed5b00943d4c2653e50c9c0bc4696a16af52a5" => :el_capitan
    sha256 "5f6e4184cbb3881095d7e1cccf37927c7ee189eaf34ee2e61654a6c1d76ca332" => :yosemite
    sha256 "2ba217c4d0f20ae3c3e9496623d4c80a33735723f0fcff27e3920422567ee59a" => :mavericks
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

