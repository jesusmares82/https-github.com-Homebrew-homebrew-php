require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class PhpCsFixer < Formula
  include Language::PHP::Composer

  desc "A tool to automatically fix PHP coding standards issues"
  homepage "http://cs.sensiolabs.org"
  url "https://github.com/FriendsOfPHP/PHP-CS-Fixer/archive/v2.5.0.tar.gz"
  sha256 "2c423ff78eff932787131e7f425930f3cdd101e9cfcda080da0a8a83ede6eb04"
  head "https://github.com/FriendsOfPHP/PHP-CS-Fixer.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "44e68b713dfcf5495b931d52d48b6d3bb731bd5ca114893ecab417b7330ea895" => :sierra
    sha256 "7531a9c14e669bf23966918ff8b31c7ed930dc6fa008a00b3c4883fe988bdbf1" => :el_capitan
    sha256 "382d85b0e6b1a947b29cba671a8268f3521b37a8c2c3e286e667a5bd23c29e8c" => :yosemite
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
