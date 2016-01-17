require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class SymfonyInstaller < Formula
  include Language::PHP::Composer

  desc "Create Symfony framework projects."
  homepage "https://github.com/symfony/symfony-installer"
  url "https://github.com/symfony/symfony-installer.git",
    :tag => "v1.5.0",
    :revision => "74311cd7ffacba6a1246d5cd5fc1a6d90037fe61"
  head "https://github.com/symfony/symfony-installer.git"

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
