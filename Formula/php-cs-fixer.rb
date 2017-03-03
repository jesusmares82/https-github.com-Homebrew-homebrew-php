require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class PhpCsFixer < Formula
  include Language::PHP::Composer

  desc "A tool to automatically fix PHP coding standards issues"
  homepage "http://cs.sensiolabs.org"
  url "https://github.com/FriendsOfPHP/PHP-CS-Fixer/archive/v2.1.1.tar.gz"
  sha256 "546a9fc908e00d121c5c02d7bbd7df198afd42b4e950b527f88ec61bd1a0c8dd"
  head "https://github.com/FriendsOfPHP/PHP-CS-Fixer.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "17263415a355bbf5aac5b17d034394b4340e52e63fad9ee6c35ea6a9bc0c5643" => :sierra
    sha256 "232a3a6ce24ce756b518869453771a171a318716e4e56fa3dc2e82a8a629389d" => :el_capitan
    sha256 "8a91a22441c63c2db1df1b474abbdbade33f3539d5593893f105f74fe6a1d5ed" => :yosemite
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
