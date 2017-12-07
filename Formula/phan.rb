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
    sha256 "6464c32348b39e314315435dc089b4786d018c1f1cde092d94e791e479f7466f" => :high_sierra
    sha256 "ffad130b29c43cfe2f30fc7272f8b0c74c5535defff734d9f2c7096fd0e6e8af" => :sierra
    sha256 "88522ac66b097be30ff9ca9806697be42e5d8113e61773b5ae859fc74924a29f" => :el_capitan
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
