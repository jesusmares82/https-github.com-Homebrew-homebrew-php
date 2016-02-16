require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Drupalconsole < AbstractPhpPhar
  init
  desc "CLI tool for Drupal 8"
  homepage "https://drupalconsole.com/"
  url "https://github.com/hechoendrupal/DrupalConsole/releases/download/0.10.11/drupal.phar"
  sha256 "1ee7ddc61aae5122f63405599f50e442621d2a27817d5701024b25877bd2d552"

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
