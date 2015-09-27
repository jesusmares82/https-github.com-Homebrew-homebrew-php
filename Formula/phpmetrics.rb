require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpmetrics < AbstractPhpPhar
  init
  desc "Static analysis tool for PHP"
  homepage "http://www.phpmetrics.org/"
  url "https://github.com/Halleck45/PhpMetrics/raw/34cf0888e7225d743fc01b467fbbd8a1d54226a6/build/phpmetrics.phar"
  version "1.4.1"
  sha256 "77fd4f29f76bf3f8c623e415ee834692077e9b49bd340a0c896f58a9697fe9a3"

  test do
    system "phpmetrics", "--version"
  end
end
