require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Composer < AbstractPhpPhar
  init
  desc "Dependency Manager for PHP"
  homepage "http://getcomposer.org"
  url "https://getcomposer.org/download/1.0.0-beta1/composer.phar"
  version "1.0.0-beta1"
  sha256 "4344038a546bd0e9e2c4fa53bced1c7faef1bcccab09b2276ddd5cc01e4e022a"
  head "https://getcomposer.org/composer.phar"

  bottle do
    cellar :any_skip_relocation
    sha256 "59113669748f1c9803d3e618428f8b557edbc7df70c235996b01a224fca0a98c" => :el_capitan
    sha256 "9c53a17d3f881673d2a101d4bd0b184ca7ef90bf7bad0ba2411d958b421d1442" => :yosemite
    sha256 "47258fd64cd1c1d3d1fbcdeb95f826de4cc6de4b717192261a939c6fe8b62c57" => :mavericks
  end

  test do
    system "composer", "--version"
  end
end
