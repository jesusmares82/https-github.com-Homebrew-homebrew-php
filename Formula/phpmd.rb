require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpmd < AbstractPhpPhar
  init
  desc "PHP Mess Detector"
  homepage "http://phpmd.org"
  url "http://static.phpmd.org/php/2.6.0/phpmd.phar"
  sha256 "69bec1176370a3bcbb81e1d422253f70305432ecf5b2c50d04ec33adb0e20f7a"
  head "https://github.com/phpmd/phpmd.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "2a18c33dafc33764e2797052829e5d442a5477e23d36e2ab3924a5b498cdd868" => :sierra
    sha256 "46171e2d234fa9ad7032827fa70bdfe50be18fcc0ef8f0082c3929d9eeaec556" => :el_capitan
    sha256 "46171e2d234fa9ad7032827fa70bdfe50be18fcc0ef8f0082c3929d9eeaec556" => :yosemite
  end

  test do
    system "#{bin}/phpmd", "--version"
  end
end
