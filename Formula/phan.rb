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
    sha256 "ce1cac3f8b542a71da05f94d4115bb3b043c68b2c823a28f4a91b5f432fe6000" => :el_capitan
    sha256 "df9a717231d8aa8133a14caccd75b9480d43d44259e8863dec6e6795ab86a17b" => :yosemite
    sha256 "b5e233ba17c17580ea5d671fe4c45a0aa5af9fbce7078191e9fe8d8e0d58dcb6" => :mavericks
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
