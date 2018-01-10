require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class PhpCsFixer < Formula
  include Language::PHP::Composer

  desc "A tool to automatically fix PHP coding standards issues"
  homepage "http://cs.sensiolabs.org"
  url "https://github.com/FriendsOfPHP/PHP-CS-Fixer/archive/v2.10.0.tar.gz"
  sha256 "4a35e08f1638bf1f6ddaeee57d355e0e43d1fb3008eba9391f7d5684bfb345f3"
  head "https://github.com/FriendsOfPHP/PHP-CS-Fixer.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "c03ab9b32304fa97d75fef13a318ad942446ace080d541488e3b85fde6015ab8" => :high_sierra
    sha256 "701a1a085b7a262f806ffb7946028827694254fed2171875d754c9bb7dc36b05" => :sierra
    sha256 "2ec3c47c7637020248aa5f80562a1b9e40ca30139d5490464fdfc2121ffd4109" => :el_capitan
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
