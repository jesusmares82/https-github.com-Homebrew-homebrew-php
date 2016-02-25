require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Drupalconsole < AbstractPhpPhar
  init
  desc "CLI tool for Drupal 8"
  homepage "https://drupalconsole.com/"
  url "https://github.com/hechoendrupal/DrupalConsole/releases/download/0.10.12/drupal.phar"
  sha256 "ac99afd5bcdc8f7dfe7c2e4fcd36f1f0809aa505490777ec5a05c930d8c2f3d5"

  bottle do
    cellar :any_skip_relocation
    sha256 "50f0c0083f7bc4943d2a3e844f490a6588454c0cb8b1fb29d54d03e817e49fe1" => :el_capitan
    sha256 "f1ebcb67c8c0f5b7b17b469c054fe5eeecd8e72a77052c3f7dc21769c59b2720" => :yosemite
    sha256 "4ae96a602188286ab52ab11270d90f336b8f6a37b495c784e48d7cf90036366a" => :mavericks
  end

  def install
    bin.install "drupal.phar" => "drupal"
  end

  test do
    system "drupal", "--version"
  end
end
