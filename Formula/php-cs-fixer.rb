require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class PhpCsFixer < Formula
  include Language::PHP::Composer

  desc "A tool to automatically fix PHP coding standards issues"
  homepage "http://cs.sensiolabs.org"
  url "https://github.com/FriendsOfPHP/PHP-CS-Fixer/archive/v2.8.2.tar.gz"
  sha256 "72e3159eb3603c0a19f1f181cc875bdf4587ec9555f24431ee29a575bddf3a09"
  head "https://github.com/FriendsOfPHP/PHP-CS-Fixer.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "4143431bf9a9743fb66bb575250b6b3c65145d740d18cb1a1b9641ef23c2a04c" => :high_sierra
    sha256 "b21f5c6145f3f2db180c42d7ac3c03c9da3089a44f9bf50aaf8f5eb8e9b7e155" => :sierra
    sha256 "a44e2664febaa11daeac0645bd2c3c3d50c675060cbeee33e8bfcae96633b2ac" => :el_capitan
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
