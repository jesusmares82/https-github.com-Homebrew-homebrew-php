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
    sha256 "74b974831bc508b2254dd714d5f9bdafdb0a4b4753a5f5bf59e430de46156783" => :sierra
    sha256 "61f87a75f51a87d37549fbb0736c84831851c110b25e8e653d3a02bf818cb894" => :el_capitan
    sha256 "ee4fe354a4d768c3167e8d1316379ea32abd1514da2f42a68db03fd163122e64" => :yosemite
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
