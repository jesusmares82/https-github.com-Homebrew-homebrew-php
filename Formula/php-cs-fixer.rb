require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class PhpCsFixer < Formula
  include Language::PHP::Composer

  desc "A tool to automatically fix PHP coding standards issues"
  homepage "http://cs.sensiolabs.org"
  url "https://github.com/FriendsOfPHP/PHP-CS-Fixer/archive/v2.7.2.tar.gz"
  sha256 "a623c9863ba5e7e39efff6abaadbb643f916ce90f44c6107f91896905db9d596"
  head "https://github.com/FriendsOfPHP/PHP-CS-Fixer.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "860e9b77b5d032c5feaa136080ab6dcab4c9771b3a44a1308ae4c9faf6b400fe" => :high_sierra
    sha256 "5fab1e528a1cf55aa5624c8b35c9664bf3e7084ddac12d11debc5cf425793d6a" => :sierra
    sha256 "fba66946c25a147448f49f496164d36b3ccebce944f76b956ed77323c96cdabf" => :el_capitan
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
