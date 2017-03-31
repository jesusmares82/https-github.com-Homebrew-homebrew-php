require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class PhpCsFixer < Formula
  include Language::PHP::Composer

  desc "A tool to automatically fix PHP coding standards issues"
  homepage "http://cs.sensiolabs.org"
  url "https://github.com/FriendsOfPHP/PHP-CS-Fixer/archive/v2.2.0.tar.gz"
  sha256 "dbb5a6d8c44d0c68c2e483fa85a694150881d389881f25142749004f5337b273"
  head "https://github.com/FriendsOfPHP/PHP-CS-Fixer.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "f67f9c3e5965ab1bd1b65d61abcd7c353b4e38474521cbf9b4a29f349a14f7b9" => :sierra
    sha256 "d6e4fbdf4534fe788277101f1e18d33e3f325a882724b5f310a56af5c51a389c" => :el_capitan
    sha256 "48e4936243418ef56309ce441ce77d45bc4223517d67720bf56f2c4a33999bc8" => :yosemite
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
