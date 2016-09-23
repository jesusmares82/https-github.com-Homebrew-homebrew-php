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
    sha256 "9ae24af10acf13fe1bc9db51b8d1b2175dda9253ca58d97f0e9780f46bc53bf9" => :sierra
    sha256 "6786e1099623b69cebcb5e4e280fb4e7c00986b95e6c6f1c698c4b47ec282787" => :el_capitan
    sha256 "c8830caa28f98aaed09889b7bc5a45fd216107b15555324b52c11e250e3af222" => :yosemite
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
