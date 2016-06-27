require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class SymfonyInstaller < Formula
  include Language::PHP::Composer

  desc "Create Symfony framework projects."
  homepage "https://github.com/symfony/symfony-installer"
  url "https://github.com/symfony/symfony-installer.git",
    :tag => "v1.5.4",
    :revision => "1e8ebb99917309d8eef7cd44e8340102c3e4c42d"
  head "https://github.com/symfony/symfony-installer.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "37cd3803918b16cf26ec3412dd48f0c6acc5df4d4a991dacd344fc35f1983f14" => :el_capitan
    sha256 "31ca104f298ec464d795177608febb5c3c794d8117800d5cc6c9045a5e6c0a3d" => :yosemite
    sha256 "513db890222e2e7c49f6addc3c087282c7ded3dd33fc7c81c373dfbb93b8345d" => :mavericks
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
