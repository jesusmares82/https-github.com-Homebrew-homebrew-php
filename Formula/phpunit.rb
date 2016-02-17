require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "http://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.2.8.phar"
  sha256 "160bbfaee74c5f91b04776da98ee176cf2b5bc5635e7abd19216c6f2883b5446"

  bottle do
    cellar :any_skip_relocation
    sha256 "e1defcf43addb5fbd4cf0590c1f4304d56e236227ec9bf11dba1814ec63d6282" => :el_capitan
    sha256 "86216cfc69a00ee25639c2401d99cc8f8ede257907671ad4c94cf13be017d110" => :yosemite
    sha256 "4cb9249caa60db71e36ce275723df6f4396ba43ccf50dc26687582fce63238c7" => :mavericks
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("phpunit --version").include?(version)
  end
end
