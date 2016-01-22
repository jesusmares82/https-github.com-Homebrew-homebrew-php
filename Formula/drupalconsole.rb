require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Drupalconsole < AbstractPhpPhar
  init
  desc "CLI tool for Drupal 8"
  homepage "https://drupalconsole.com/"
  url "https://github.com/hechoendrupal/DrupalConsole/releases/download/0.10.5/drupal.phar"
  sha256 "3c9269acedf4064f7016859860bb5fa0394c96dd4e6a82339034d030d0806f81"

  def install
    bin.install "drupal.phar" => "drupal"
  end

  test do
    system "drupal", "--version"
  end
end
