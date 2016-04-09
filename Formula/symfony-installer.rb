require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class SymfonyInstaller < Formula
  include Language::PHP::Composer

  desc "Create Symfony framework projects."
  homepage "https://github.com/symfony/symfony-installer"
  url "https://github.com/symfony/symfony-installer.git",
    :tag => "v1.5.1",
    :revision => "ffc1ad64b821f996b3def57fd916fc58ea3308a6"
  head "https://github.com/symfony/symfony-installer.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "c03be845c4c3d8e66cffdc370bc2f2ef151e74a7a0e04a785f87aed02e3ee6d1" => :el_capitan
    sha256 "bf2e37808fe95eded99f12dbd1b0989dc2ba71abb73d314d7e1003a7f342b7a0" => :yosemite
    sha256 "58f4f940a4110994e109430cc1c5cdaaba59a1a714f8df1d2f2c5599fc7699b0" => :mavericks
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
