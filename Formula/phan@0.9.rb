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
    rebuild 1
    sha256 "4b16a76d1bb449d82c8b1f727f732564e042a60422b4b61d80edf6a79d264e49" => :high_sierra
    sha256 "2b957e986f915bfe40f4af89de0bf630411d3b382e07384607f9b860312ee71c" => :sierra
    sha256 "b619b500ac28bba2626b7128d4c2799298177520ec6cc782ea2c296488babaec" => :el_capitan
  end

  depends_on "php71-ast"
  depends_on "php71"

  keg_only :versioned_formula

  def install
    composer_install
    prefix.install Dir["*"]
    bin.install_symlink prefix/"phan"
  end

  test do
    system "#{bin}/phan", "--help"
  end
end
