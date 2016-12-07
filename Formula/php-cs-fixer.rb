require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class PhpCsFixer < Formula
  include Language::PHP::Composer

  desc "A tool to automatically fix PHP coding standards issues"
  homepage "http://cs.sensiolabs.org"
  url "https://github.com/FriendsOfPHP/PHP-CS-Fixer/archive/v2.0.0.tar.gz"
  sha256 "16e40ef65438d5a4a903142be744b05430eea64bffd42519175cebffd6387888"
  head "https://github.com/FriendsOfPHP/PHP-CS-Fixer.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "0f4c0ad63d5995e7943489c42ab2d7f3f03685217caa4ded73c46d90c52a15ff" => :sierra
    sha256 "23b07eeca182b38e7630308a15209d980fbc2e9899b0742f6852b1c2813ea54c" => :el_capitan
    sha256 "80d2dd4c74ed2da6dff876ce315ce0fd1bbdd88a614007772165bc1d8c8bd960" => :yosemite
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
