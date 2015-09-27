require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpmd < AbstractPhpPhar
  init
  desc "PHP Mess Detector"
  homepage "http://phpmd.org"
  url "http://static.phpmd.org/php/2.2.3/phpmd.phar"
  sha256 "5cd9d4754a0d2c41a403afe6b7b75e6994d90f8e8df3600a200398dd4271a31b"
  head "https://github.com/phpmd/phpmd.git"

  test do
    system "phpmd", "--version"
  end
end
