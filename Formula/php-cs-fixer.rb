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
    sha256 "30984a93e535af0d583a2926270fa21e89a04e91ee599d34f811f1b689b23223" => :sierra
    sha256 "66fafd2d50f574239a387414e305537b0a17d60541c8b172310b73ca3f8c5e7b" => :el_capitan
    sha256 "34497597f67a02b1b58bb948dbc01533cfa60397297f5cde8bc5bbb7bb85dae2" => :yosemite
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
