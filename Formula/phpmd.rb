require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpmd < AbstractPhpPhar
  init
  desc "PHP Mess Detector"
  homepage "http://phpmd.org"
  url "http://static.phpmd.org/php/2.3.2/phpmd.phar"
  sha256 "81b2c8cfc45c4190e504a25a5c207a5eb5c85e0f0809b2620e2440bfef3edd7c"
  head "https://github.com/phpmd/phpmd.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "c9126a56f86d4650246698f14e4c36217cab86d131fbd948dcee40c30d3cbb55" => :el_capitan
    sha256 "96d453bb29f2256c7b79fded8f995be30379d188cae05bdf1c904cdac1b03df1" => :yosemite
    sha256 "01d1670856b0d400e2fbce0374b3ce97cd39fe30cd6643b731beda4b522abc2c" => :mavericks
  end

  test do
    system "phpmd", "--version"
  end
end
