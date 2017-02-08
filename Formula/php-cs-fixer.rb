require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class PhpCsFixer < Formula
  include Language::PHP::Composer

  desc "A tool to automatically fix PHP coding standards issues"
  homepage "http://cs.sensiolabs.org"
  url "https://github.com/FriendsOfPHP/PHP-CS-Fixer/archive/v2.0.1.tar.gz"
  sha256 "3e1f7f0bf7fb02e0e74982d1b34832714fe546131013b26e73118f0171ed3c3e"
  head "https://github.com/FriendsOfPHP/PHP-CS-Fixer.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "96053b419feb78c869f37493ccbb15c0f2134bd4133d90ea2b7bc4eb221c5467" => :sierra
    sha256 "a52de5eb2f3c4fcb416620ab12bbc949051add11a92c50e17e7f4f1218ed0cd5" => :el_capitan
    sha256 "28ba5dc7d5d014706e33e4db0795a9544c50848a5b4b5483f87feed4552ec504" => :yosemite
  end

  depends_on PhpMetaRequirement

  def install
    composer_install
    prefix.install Dir["*"]
    bin.install_symlink prefix/"php-cs-fixer"
  end

  test do
    system "#{bin}/php-cs-fixer", "--version"
  end
end
