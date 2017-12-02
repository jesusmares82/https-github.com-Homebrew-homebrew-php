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
    sha256 "361fcd5108c46c1aa8422e5f8588efdcdc0872fd0894fc62ca85cb1a94ebeb95" => :high_sierra
    sha256 "9d597659f83a389278e26f1c1b4de3d0187705119ee7f77ec3927dbfc77a9f1d" => :sierra
    sha256 "8fd3fa4da492758600c2427a1d657667ccfa4f7cfa191f9ad3abb2b04ea6205d" => :el_capitan
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
