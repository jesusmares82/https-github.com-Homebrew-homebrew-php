require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class PhpCsFixer < Formula
  include Language::PHP::Composer

  desc "Tries to fix coding standards issues"
  homepage "http://cs.sensiolabs.org"
  url "https://github.com/FriendsOfPHP/PHP-CS-Fixer/archive/v1.12.1.tar.gz"
  sha256 "595d24bdd805b0cc1a43a7f2a5035117c72f8b3b6f8eb33011048943744e3c68"
  head "https://github.com/FriendsOfPHP/PHP-CS-Fixer.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "9b525e89c9ce723cbe7e347ce57a48e1f21b9b2243f488b564ae89b1f401e117" => :el_capitan
    sha256 "e741d6606a0d663b327b8354862cedaa7e101120f120ac638c86e168b2c10821" => :yosemite
    sha256 "2854acfd1a12df8e4e9cf25de0c266ae50912c65dd9ad9508fd82a3951519745" => :mavericks
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
