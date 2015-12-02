require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class PhpCsFixer < Formula
  desc "Tries to fix coding standards issues"
  homepage "http://cs.sensiolabs.org"
  url "https://github.com/FriendsOfPHP/PHP-CS-Fixer/archive/v1.11.tar.gz"
  sha256 "913d9561257b29350d2b9a7ba82fa6f1e205ef9833232086ca928a70bb29663b"
  head "https://github.com/FriendsOfPHP/PHP-CS-Fixer.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "ade14a00772c49a3dd9b14365f6153f9e0f7300cf8abc721449545c5bf7141ff" => :el_capitan
    sha256 "dcd30ac28e6c6a9c09611b64659de733315c5cbbd9e72cde56933bddee4f1a09" => :yosemite
    sha256 "3d1ab0d0ab7241bb50589c8dae68bc5c6ce049f4fbfa3abe27a481a37b17d5ba" => :mavericks
  end

  depends_on PhpMetaRequirement
  depends_on "composer"

  def install
    system "composer", "install"
    prefix.install Dir["*"]
    bin.install_symlink prefix/"php-cs-fixer"
  end

  test do
    system "php-cs-fixer", "--version"
  end
end
