require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class PhpCsFixer < Formula
  include Language::PHP::Composer

  desc "A tool to automatically fix PHP coding standards issues"
  homepage "http://cs.sensiolabs.org"
  url "https://github.com/FriendsOfPHP/PHP-CS-Fixer/archive/v2.3.2.tar.gz"
  sha256 "14b1b2c6812677dfbaa6c75b3c206fa2aab1553bd210a13a40d21ace19c8d4a0"
  head "https://github.com/FriendsOfPHP/PHP-CS-Fixer.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "f5230c4e90273b3d6051c9a1790b4d70f0827bf0f1945acf325be0526f27900c" => :sierra
    sha256 "e892c00e5dcd901211521bc60f16c70307f464010caa9c21b889d9e5187cef2f" => :el_capitan
    sha256 "f03c772f0051881f4866f768a4d73a1823294aeb042b4fd1b8ae0eacb4cca5a1" => :yosemite
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
