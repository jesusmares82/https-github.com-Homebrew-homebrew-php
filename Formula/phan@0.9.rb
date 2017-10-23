require File.expand_path("../../language/php", __FILE__)

class PhanAT09 < Formula
  include Language::PHP::Composer

  desc "Static analyzer for PHP"
  homepage "https://github.com/phan/phan"
  url "https://github.com/phan/phan/archive/0.9.7.tar.gz"
  sha256 "1a55d525464425a28b9cc467e2593ee687a19f1be62f8c3108feacdff8a2ca65"
  head "https://github.com/phan/phan.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "1c21a054e0568a66b797446a01b70f02f920281599c1785e88e46a458d10f1bb" => :high_sierra
    sha256 "e463ab6226e3fe2b27b0a914399e1a4f793e4ad70dd28c43cce4bb0797b8c68f" => :sierra
    sha256 "242ade6be533527d804f7a5267175400f136eca0c31d44f1ffd4377d58d52857" => :el_capitan
  end

  depends_on "php71-ast"
  depends_on "php71"

  def install
    composer_install
    prefix.install Dir["*"]
    bin.install_symlink prefix/"phan"
  end

  test do
    system "#{bin}/phan", "--help"
  end
end
