require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class PhpunitSkeletonGenerator < AbstractPhpPhar
  init
  desc "Generate skeleton test classes"
  homepage "http://phpunit.de/manual/current/en/"
  url "https://phar.phpunit.de/phpunit-skelgen-2.0.1.phar"
  sha256 "d23d31304348faf2fad6338c498d56864c5ccb772ca3d795fea829b7db45c747"

  bottle do
    cellar :any_skip_relocation
    sha256 "1ed95cb8a92f486f6dcaf6b5e2c81f23ab5c003823550831297cf62712f3969c" => :el_capitan
    sha256 "3c3caa5b9d28b44188cdccad88cf722a97fdf84d657bd88b6c9c16ca79cfc480" => :yosemite
    sha256 "2f70dcb0ea0d87b940b757a8b5488c2de2dea3dadae687dfbc92930972f4ab35" => :mavericks
  end

  def phar_file
    "phpunit-skelgen-#{version}.phar"
  end

  test do
    system "phpunitskeletongenerator", "--version"
  end
end
