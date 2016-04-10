require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "http://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.3.1.phar"
  sha256 "5602ea831312d8cf4d7e79decee9dfdf15f667bec50d5a378762d5283f7cf99d"

  bottle do
    cellar :any_skip_relocation
    sha256 "5b4a470e4bb86fea3eb3bcd7d44d720e9acfb2607d88c1c6c5c779db58eb7720" => :el_capitan
    sha256 "28da4a827215ff1343c53de6edef15a3347f65b687ecc27b098cfa6c0d7de116" => :yosemite
    sha256 "5298a8e6dd81ba952ed11d9dfd73ad07be302217a9d0d9f06f931f8a650e884a" => :mavericks
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("phpunit --version").include?(version)
  end
end
