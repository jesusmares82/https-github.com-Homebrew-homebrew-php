require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "http://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.1.6.phar"
  sha256 "59f51e287c8b4b6313fb161b1fa97ec4d99c4196f053241fa590bb73b1181ad3"

  bottle do
    cellar :any_skip_relocation
    sha256 "a3eb9b6c32b1973627840993a16f217b8e3eb0efe807e2f45eefa29bf5de2464" => :el_capitan
    sha256 "5a911444dcee51d7e45fdc8483814cf785e9da05e19f4ca4e179f69f9f765a05" => :yosemite
    sha256 "5a911444dcee51d7e45fdc8483814cf785e9da05e19f4ca4e179f69f9f765a05" => :mavericks
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("phpunit --version").include?(version)
  end
end
