require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class PhpCsFixer < Formula
  include Language::PHP::Composer

  desc "A tool to automatically fix PHP coding standards issues"
  homepage "http://cs.sensiolabs.org"
  url "https://github.com/FriendsOfPHP/PHP-CS-Fixer/archive/v2.8.3.tar.gz"
  sha256 "28059e131d87d7b3facb2fa6dc6330ee77af39faf246d1b811ddd3a547b80994"
  head "https://github.com/FriendsOfPHP/PHP-CS-Fixer.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "9ce6f920956a60f99951dab9950f25cbad112ac60bc4543aa649db34ac011a4f" => :high_sierra
    sha256 "c0a3fc432ecdd1f319d5fb82c029d655a9cfa92f05c27dbbe61d5915598eecec" => :sierra
    sha256 "1b5b176ad44e0684fce32df8ee6f07df443e03a91064fa64ac6fbc87e6517429" => :el_capitan
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
