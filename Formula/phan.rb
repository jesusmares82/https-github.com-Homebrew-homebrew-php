require File.expand_path("../../language/php", __FILE__)

class Phan < Formula
  include Language::PHP::Composer

  desc "Static analyzer for PHP"
  homepage "https://github.com/etsy/phan"
  url "https://github.com/etsy/phan/archive/0.6.tar.gz"
  sha256 "f04a15099be338e83e389d215ebda057215755b8495123fad544bb35ecb7b161"
  head "https://github.com/etsy/phan.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "f789cb6611997d06341199f45564f14614ef21a2aa38eb1f7f50e7303d98a9ea" => :el_capitan
    sha256 "2ab0b3cddf7b8bb2b042501c66f829afb200d7956a427b5797bc7773693e9f1c" => :yosemite
    sha256 "335c9d7d864cdbdc0821546e62e3f2066322b4448e8c0c7adf689c48b0f13d48" => :mavericks
  end

  depends_on "php70-ast"
  depends_on "php70"

  def install
    composer_install
    prefix.install Dir["*"]
    bin.install_symlink prefix/"phan"
  end

  test do
    system "phan", "-h"
  end
end
