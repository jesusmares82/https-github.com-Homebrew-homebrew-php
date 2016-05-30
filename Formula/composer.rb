require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Composer < AbstractPhpPhar
  init
  desc "Dependency Manager for PHP"
  homepage "http://getcomposer.org"
  url "https://getcomposer.org/download/1.1.1/composer.phar"
  sha256 "7f26efee06de5a1a061b6b1e330f5acc9ee69976d1551118c45b21f358cbc332"
  revision 2
  head "https://getcomposer.org/composer.phar"

  bottle do
    cellar :any_skip_relocation
    sha256 "f2708d441e0b40ba4de79850e4d530aee1a41f30a2343ce722393d03deb108ba" => :el_capitan
    sha256 "f0cef14d3d5a729b089874e077eb22f888774e9701639bce8eebdabf250c0acb" => :yosemite
    sha256 "459ee080a94ef4fa35442d6f0aebd7b248c7d41e39b78f2fc088bb75d2eaed49" => :mavericks
  end

  test do
    system "composer", "--version"
  end
end
