require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class PhpCsFixer < Formula
  desc "Tries to fix coding standards issues"
  homepage "http://cs.sensiolabs.org"
  url "https://github.com/FriendsOfPHP/PHP-CS-Fixer/archive/v1.11.tar.gz"
  sha256 "913d9561257b29350d2b9a7ba82fa6f1e205ef9833232086ca928a70bb29663b"
  head "https://github.com/FriendsOfPHP/PHP-CS-Fixer.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "9b525e89c9ce723cbe7e347ce57a48e1f21b9b2243f488b564ae89b1f401e117" => :el_capitan
    sha256 "e741d6606a0d663b327b8354862cedaa7e101120f120ac638c86e168b2c10821" => :yosemite
    sha256 "2854acfd1a12df8e4e9cf25de0c266ae50912c65dd9ad9508fd82a3951519745" => :mavericks
  end

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
