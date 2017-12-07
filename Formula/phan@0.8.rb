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
    rebuild 1
    sha256 "a83d5ed77d196f374f39e8a90adb274a656080ad57e0825269f8022638fe2869" => :high_sierra
    sha256 "51c0a42e886ebac417e22f9ab2bf723256b8e39d804b4a13014a796ab0d740eb" => :sierra
    sha256 "b20f87a2b889eef14c62a9ac235810c52ab9195a752c5a8b0f86185bdd9b549b" => :el_capitan
  end

  keg_only :versioned_formula

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
