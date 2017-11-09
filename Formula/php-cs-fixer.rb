require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class PhpCsFixer < Formula
  include Language::PHP::Composer

  desc "A tool to automatically fix PHP coding standards issues"
  homepage "http://cs.sensiolabs.org"
  url "https://github.com/FriendsOfPHP/PHP-CS-Fixer/archive/v2.8.1.tar.gz"
  sha256 "c24d20d09554c92568de323144dcdefb07a94cadaa8d975a8db470093f93d5bd"
  head "https://github.com/FriendsOfPHP/PHP-CS-Fixer.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "9d933965853f9d4e97efe6ca4c539b5d89533b8d243eb86a94e9cdf0ce9b83a5" => :high_sierra
    sha256 "fa64ff33895c7ccc0806e0bdd553bc314e55512a5e83603259b17e21e26fd81c" => :sierra
    sha256 "ed50f68578af2f4defd74958a45371124a10579bad6be1e758b94f21a2a4e6b1" => :el_capitan
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
