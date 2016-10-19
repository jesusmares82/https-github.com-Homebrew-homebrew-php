require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class PhpCsFixer < Formula
  include Language::PHP::Composer

  desc "Tries to fix coding standards issues"
  homepage "http://cs.sensiolabs.org"
  url "https://github.com/FriendsOfPHP/PHP-CS-Fixer/archive/v1.12.2.tar.gz"
  sha256 "9715863f2e3419715b4527e2452492c20e3e43384e2a665ecf27ddc6f5d448fb"
  head "https://github.com/FriendsOfPHP/PHP-CS-Fixer.git"

  bottle do
  end

  depends_on PhpMetaRequirement

  def install
    composer_install
    prefix.install Dir["*"]
    bin.install_symlink prefix/"php-cs-fixer"
  end

  test do
    system "php-cs-fixer", "--version"
  end
end
