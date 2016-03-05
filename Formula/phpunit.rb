require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "http://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.2.10.phar"
  sha256 "7774bb7205e312ce1311a4e6ec120170e63cade9671ae69fba4e526c3335c659"

  bottle do
    cellar :any_skip_relocation
    sha256 "603e29d80781968be7b19bbfda0f2b80234b9b2b768708cb576965038fffa950" => :el_capitan
    sha256 "14a199d0b0aad5038cdee4d19c088f91f9f5ef0a16346f52d15ee5bebcd925cc" => :yosemite
    sha256 "54b94e68092b634bad8472a17fd78f8949c4938b432553b2ded5fc4d0316802d" => :mavericks
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("phpunit --version").include?(version)
  end
end
