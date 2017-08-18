require File.expand_path("../../language/php", __FILE__)

class Phan < Formula
  include Language::PHP::Composer

  desc "Static analyzer for PHP"
  homepage "https://github.com/etsy/phan"
  url "https://github.com/etsy/phan/archive/0.9.4.tar.gz"
  sha256 "af2f405b428949c70b11a7351f890cb3d49fdda25e082fb7e314f4b5c2fe39ee"
  head "https://github.com/etsy/phan.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "d905ad7f75ea9724f1c2afc9569458420eb9caaa99700178333989645529b17a" => :sierra
    sha256 "d9d0adc923768c108f8683c3168a8003bb3912c0177690bc99b0c25f65d7aac5" => :el_capitan
    sha256 "dcf09f258185933e9cae74a116636828bee947c36aa7673b64e7e7d274592d44" => :yosemite
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
