require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class PhpCsFixer < Formula
  include Language::PHP::Composer

  desc "A tool to automatically fix PHP coding standards issues"
  homepage "http://cs.sensiolabs.org"
  url "https://github.com/FriendsOfPHP/PHP-CS-Fixer/archive/v2.1.0.tar.gz"
  sha256 "650bcb819eaa47af854057f2a81ee309392df735d4a042e3bf2a93891c36db43"
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
