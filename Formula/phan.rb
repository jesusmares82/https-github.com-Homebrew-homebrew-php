require File.expand_path("../../language/php", __FILE__)

class Phan < Formula
  include Language::PHP::Composer

  desc "Static analyzer for PHP"
  homepage "https://github.com/phan/phan"
  url "https://github.com/phan/phan/archive/0.11.0.tar.gz"
  sha256 "c62613d20c69568a9790ceafdb066658bd99e914ae955976bd4c68e2d3047053"
  head "https://github.com/phan/phan.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "1367e7dee09300327a86374709b631a2908b29f02b19120277602f09a741adf2" => :high_sierra
    sha256 "9ab21b753363215c0263be7d155e4a1353e90d4431c3693a6f3cf42fcca02024" => :sierra
    sha256 "94efb4985bb039de568cc1cd3917e683a850c94117e512508930569b84ce2307" => :el_capitan
  end

  depends_on "php72-ast"
  depends_on "php72"

  conflicts_with "phan@0.10", :because => "it provivides a phan binary"
  conflicts_with "phan@0.8", :because => "it provivides a phan binary"

  def install
    composer_install
    prefix.install Dir["*"]
    bin.install_symlink prefix/"phan"
  end

  test do
    system "#{bin}/phan", "--help"
  end
end
