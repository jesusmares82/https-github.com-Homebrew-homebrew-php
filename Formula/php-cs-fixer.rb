require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class PhpCsFixer < Formula
  include Language::PHP::Composer

  desc "A tool to automatically fix PHP coding standards issues"
  homepage "http://cs.sensiolabs.org"
  url "https://github.com/FriendsOfPHP/PHP-CS-Fixer/archive/v2.0.0.tar.gz"
  sha256 "16e40ef65438d5a4a903142be744b05430eea64bffd42519175cebffd6387888"
  head "https://github.com/FriendsOfPHP/PHP-CS-Fixer.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "f87c39d6bc17e4f76f68820049d78739c59adeba50a61d8016cbad5887ec9302" => :sierra
    sha256 "686fb1c00d68cdfe6a6d26534ab47af0223f4e0f9a2636a0f7b3dedbaaa65d03" => :el_capitan
    sha256 "24b210bef419bf7314bd5e871672d3fb2c2d49ed8fc2a6a66e760e6c02f925da" => :yosemite
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
