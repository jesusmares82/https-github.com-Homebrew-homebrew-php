require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Composer < AbstractPhpPhar
  init
  desc "Dependency Manager for PHP"
  homepage "http://getcomposer.org"
  url "https://getcomposer.org/download/1.0.3/composer.phar"
  sha256 "78c5c0e3f41dcd4d6ee532d9ae7e23afa33bdd409d8824dff026f3991d6ad70a"
  head "https://getcomposer.org/composer.phar"

  bottle do
    cellar :any_skip_relocation
    sha256 "26a8f2ffc5cebe41b1c00fa112d0e32953a5895d87896c21e8f18f5c7b8df68a" => :el_capitan
    sha256 "ce9cc5d201fdde3d99ffb639f10e9b9a11e83581a4ae7900168defe717109760" => :yosemite
    sha256 "4f4c953ec47c2cd622c5f85036ab95ae3c9ff7422aeef08f7bd14453bb86221d" => :mavericks
  end

  test do
    system "composer", "--version"
  end
end
