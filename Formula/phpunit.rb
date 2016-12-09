require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.7.3.phar"
  sha256 "312a4b3be46029e5b182417edcc834adcea391fe52fdf5b7818dc3bb51ca4a0d"

  bottle do
    cellar :any_skip_relocation
    sha256 "898a786f60506c74758b8433b7628d262b80f05841bf17f35de4a65b64eb252a" => :sierra
    sha256 "898a786f60506c74758b8433b7628d262b80f05841bf17f35de4a65b64eb252a" => :el_capitan
    sha256 "898a786f60506c74758b8433b7628d262b80f05841bf17f35de4a65b64eb252a" => :yosemite
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunit --version").include?(version)
  end
end
