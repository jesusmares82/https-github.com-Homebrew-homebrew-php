require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class SymfonyInstaller < Formula
  include Language::PHP::Composer

  desc "Create Symfony framework projects."
  homepage "https://github.com/symfony/symfony-installer"
  url "https://github.com/symfony/symfony-installer.git",
    :tag => "v1.5.9",
    :revision => "e965861351b693b1459adb22049c4924cc825f4a"
  head "https://github.com/symfony/symfony-installer.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "f415b015f43df161f2c78e42b065481082441e0349e42119d00a4f65b2f8b8d3" => :sierra
    sha256 "8905df9c7b3be652e8bb6676ead38bea2c817d3bdb38dc5a30195017e7ecd6de" => :el_capitan
    sha256 "8d609e49978d20a51031506fb3fbfba90c53fcb97604a797b0827afc09b9aa1e" => :yosemite
  end

  depends_on PhpMetaRequirement
  depends_on "box" => :build
  depends_on "composer" => :build

  def install
    composer_install
    system "box", "build"
    bin.install "symfony.phar" => "symfony"
  end

  test do
    system "symfony", "about"
  end
end
