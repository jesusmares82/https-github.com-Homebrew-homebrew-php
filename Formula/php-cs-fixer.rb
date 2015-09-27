require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class PhpCsFixer < Formula
  desc "Tries to fix coding standards issues"
  homepage "http://cs.sensiolabs.org"
  url "https://github.com/FriendsOfPHP/PHP-CS-Fixer/archive/v1.10.tar.gz"
  sha256 "344a50a46563350916ed2ec037f8f4d56eb8f4fbf8fc2299c9020875846ded01"
  head "https://github.com/FriendsOfPHP/PHP-CS-Fixer.git"

  depends_on PhpMetaRequirement
  depends_on "composer"

  def install
    system "composer", "install"
    prefix.install Dir["*"]
    bin.install_symlink prefix/"php-cs-fixer"
  end

  test do
    system "php-cs-fixer", "--version"
  end
end
