require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class PhpCsFixer < Formula
  include Language::PHP::Composer

  desc "A tool to automatically fix PHP coding standards issues"
  homepage "http://cs.sensiolabs.org"
  url "https://github.com/FriendsOfPHP/PHP-CS-Fixer/archive/v2.3.0.tar.gz"
  sha256 "099f4a30bf64d60a4d1a4763d55c502d22b664375074ae5564356556f12e3651"
  head "https://github.com/FriendsOfPHP/PHP-CS-Fixer.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "debb97bfb74a21883f7dfede216bc599b5f25f700867e4d7690eccb5dda22314" => :sierra
    sha256 "42ff61118a68abbdc150641eab54ca38ed526bcf9654dcc09ba0cd08c5416631" => :el_capitan
    sha256 "34cb59ecd97753e157edde4086bfc8f0c521586513c9a7f8e61879449dd31dbf" => :yosemite
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
