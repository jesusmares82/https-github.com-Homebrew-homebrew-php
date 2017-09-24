require File.expand_path("../../language/php", __FILE__)

class PhanAT09 < Formula
  include Language::PHP::Composer

  desc "Static analyzer for PHP"
  homepage "https://github.com/phan/phan"
  url "https://github.com/phan/phan/archive/0.9.6.tar.gz"
  sha256 "e327fd246c545fdebe5e93d0db40c8b127a29bd941be04572ee36e4f51d2763e"
  head "https://github.com/phan/phan.git"

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
