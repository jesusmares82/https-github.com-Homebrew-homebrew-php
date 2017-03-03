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
    sha256 "eef184447a1901f43ba135314588885b8077fdb3d96d35f781be3b75cc2b156e" => :sierra
    sha256 "8f4c9db20352a07f1b78599d8d6159e97f6faa345f40f5bac82dc77afba958db" => :el_capitan
    sha256 "4b221f1927801b4022eb2b60c713ce3d2e52788c064d8e129f63b4f2f2b3ef7a" => :yosemite
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
