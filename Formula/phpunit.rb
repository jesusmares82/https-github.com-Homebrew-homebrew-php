require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "http://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.3.1.phar"
  sha256 "5602ea831312d8cf4d7e79decee9dfdf15f667bec50d5a378762d5283f7cf99d"

  bottle do
    cellar :any_skip_relocation
    sha256 "b0a441f06ff78a5b1e67fb32157be5bfecb84df1c345d4d604c6a7663b4e7208" => :el_capitan
    sha256 "64ebd210b2e0634063cd84e38c22f6c6ebf67eb4b8b7880a6cec1fa94cb00f26" => :yosemite
    sha256 "fbd5a6b33777bfc0d8df3d39ee5aa29ea3b69a4ac4da70a930c7cd70ac852472" => :mavericks
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("phpunit --version").include?(version)
  end
end
