require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class PhpCsFixer < Formula
  include Language::PHP::Composer

  desc "A tool to automatically fix PHP coding standards issues"
  homepage "http://cs.sensiolabs.org"
  url "https://github.com/FriendsOfPHP/PHP-CS-Fixer/archive/v2.6.0.tar.gz"
  sha256 "7d91a3c2002524be02cc595e5981c50a0fc559c0058b0cfe90f45b9a256a56e1"
  head "https://github.com/FriendsOfPHP/PHP-CS-Fixer.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "671a9a2d36381f0067d25e23b5ef43f6c1c86e5a8f5dfba16ef286d732be0986" => :sierra
    sha256 "b4323f6c000d31dc4fd74ce9965b3c84a276d640a430bbbd651666140f29aa06" => :el_capitan
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
