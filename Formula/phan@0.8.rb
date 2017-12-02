require File.expand_path("../../language/php", __FILE__)

class PhanAT08 < Formula
  include Language::PHP::Composer

  desc "Static analyzer for PHP"
  homepage "https://github.com/phan/phan"
  url "https://github.com/etsy/phan/archive/0.8.10.tar.gz"
  sha256 "4e552b0e764613940f32b888a13090a13ae39f35c9391061c70dc04b422c240f"
  head "https://github.com/phan/phan.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "a20416c947578a876ddc49765c7a4062d34851f743a6ab9d7356506e86c2e029" => :high_sierra
    sha256 "6c33e2354bb2a462722375b7b71c32e3b129e75dfb63c1c18512d4ca32c9e7b9" => :sierra
    sha256 "ff60810a84e60dd64031d9ed4e773d2370c7654d87dec92c497f690fa7a72b1c" => :el_capitan
  end

  depends_on "php70-ast"
  depends_on "php70"

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
