require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "http://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.5.4.phar"
  sha256 "6decad1e5236cfaebf54c1eda40d75f0dd3aee34e75a5f0d27da66062d97c9a2"

  bottle do
    cellar :any_skip_relocation
    sha256 "fbb70ab4e033a28b1395333586d9048abb007908e69a10048b44966d8c3b00e9" => :el_capitan
    sha256 "49c2d25b7e6dc6dbe9fd6b7fbca7e1703d76dbf6ed23f405130aea8a5a69ec4c" => :yosemite
    sha256 "49c2d25b7e6dc6dbe9fd6b7fbca7e1703d76dbf6ed23f405130aea8a5a69ec4c" => :mavericks
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("phpunit --version").include?(version)
  end
end
