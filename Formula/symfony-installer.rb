require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class SymfonyInstaller < Formula
  include Language::PHP::Composer

  desc "Create Symfony framework projects."
  homepage "https://github.com/symfony/symfony-installer"
  url "https://github.com/symfony/symfony-installer.git",
    :tag => "v1.5.8",
    :revision => "70b921a47372a5734d09adbbeacc5d74d77cda3d"
  head "https://github.com/symfony/symfony-installer.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "46bf5e53b3a7bddb8020ca02ac676c20d5e2b5cc8d62be6ed75eaefacaaeab71" => :el_capitan
    sha256 "67cfa4abe8f53e98e19ef55c1f80c68c68a1a055f29c4147b4a8ed2801f92a24" => :yosemite
    sha256 "2336e56c7c278ffaa917643a74d9cafa4859c9146bad800dd10a669019cfdecf" => :mavericks
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
