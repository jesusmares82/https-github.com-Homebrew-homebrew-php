require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Drupalconsole < AbstractPhpPhar
  init
  desc "CLI tool for Drupal 8"
  homepage "https://drupalconsole.com/"
  url "https://github.com/hechoendrupal/DrupalConsole/releases/download/0.11.3/drupal.phar"
  sha256 "a74fb7b7656cf854e7683cd32fc5c7f59f2ae3245f0ffebbb56f6160cf150e95"

  bottle do
    cellar :any_skip_relocation
    sha256 "5f0f33a6efa98195201fd9ee07dd0e167e91d8ca5a1f075ccd7350615ef3caaf" => :el_capitan
    sha256 "6e0e1475d51bd51beaf019e48a15eeb87806d968363bc47335ab0b4f512680d5" => :yosemite
    sha256 "dda2361d56afa627e49b4e6f19cce6ef8cd02b4df70e8bd47de9c87ce2e6bfcd" => :mavericks
  end

  def install
    bin.install "drupal.phar" => "drupal"
  end

  test do
    system "drupal", "--version"
  end
end
