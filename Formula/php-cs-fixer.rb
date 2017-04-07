require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class PhpCsFixer < Formula
  include Language::PHP::Composer

  desc "A tool to automatically fix PHP coding standards issues"
  homepage "http://cs.sensiolabs.org"
  url "https://github.com/FriendsOfPHP/PHP-CS-Fixer/archive/v2.2.1.tar.gz"
  sha256 "bca46645b31d165cd4069dc54841a1c37bd99e31e3d24e00a23fc147cfa50b90"
  head "https://github.com/FriendsOfPHP/PHP-CS-Fixer.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "cc2b71ef9b1a17e0c856ffc0a71a2d8944448600a21c4f6fd6b7f77cb302ba3d" => :sierra
    sha256 "73e15d576b63be007f05ac6b4f97bc3d230abc475338f706c6fd3b521f64b7f2" => :el_capitan
    sha256 "e608548544e2c7549ea0eb8ad9817b301a97c39780f4667ecf56006168230020" => :yosemite
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
