require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpcpd < AbstractPhpPhar
  init
  desc "Copy/Paste Detector (CPD) for PHP code"
  homepage "https://github.com/sebastianbergmann/phpcpd"
  url "https://phar.phpunit.de/phpcpd-2.0.0.phar"
  sha256 "ea4856166beb0dace104124deece3f6d43b9af6dbfe44e0bb41f45aba1d85b26"

  def phar_file
    "phpcpd-#{version}.phar"
  end

  test do
    system "phpcpd", "--version"
  end
end
