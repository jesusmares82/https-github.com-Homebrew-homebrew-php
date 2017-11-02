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
    sha256 "16c547acb9bf6b6ffe36d4932f1b111b431ccdfd06f0a0d3f80c8509de17ba1b" => :high_sierra
    sha256 "c1445e3aa1dfc74aa9e3e6a6e54ccefa25f49e03c3b88190576674dd48bfa2c3" => :sierra
    sha256 "804f09b664f7729744af91348e736c65a1cd3b39a5ad6bebb9b3adf4ec86753c" => :el_capitan
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
