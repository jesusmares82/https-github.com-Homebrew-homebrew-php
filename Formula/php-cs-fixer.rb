require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class PhpCsFixer < Formula
  include Language::PHP::Composer

  desc "A tool to automatically fix PHP coding standards issues"
  homepage "http://cs.sensiolabs.org"
  url "https://github.com/FriendsOfPHP/PHP-CS-Fixer/archive/v2.4.0.tar.gz"
  sha256 "06f1d825fc40b4927b3007967c786fbf4163d882a41e28dfbe0119a1cea79c0a"
  head "https://github.com/FriendsOfPHP/PHP-CS-Fixer.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "0ed96eaed95de63eb9d8b7bdc4285d5bac7b54efc796c410b0c277ee79f491fe" => :sierra
    sha256 "8c6c5db66c571d790d71c856b0500888a02ec5d397d1c88c080c06aa87664ad9" => :el_capitan
    sha256 "2c35f81f506abffe0c75c7b4559dff02d80be483bd2d9f99365d9719f5fe5723" => :yosemite
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
