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
    sha256 "eb325b5505e1caac2284dd753f4b78def218843a82ee020dfe49439718fe4049" => :el_capitan
    sha256 "baec86e024feafef142083624323f0cb3ac7b9517d31ba92938959759749bbd1" => :yosemite
    sha256 "bcbd3594ddafb22ccd6c82a6e970e733fdf191431ac5b8b0e705c60db75c4b29" => :mavericks
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
