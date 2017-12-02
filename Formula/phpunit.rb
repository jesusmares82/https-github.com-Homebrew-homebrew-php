require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-6.5.2.phar"
  sha256 "993f800d506551a5e42ec03da8256b59d0038acc06e0eb02b42364e5b806ba16"

  bottle do
    cellar :any_skip_relocation
    sha256 "6d4381e011c5a79c89d890e79bb3e94353e2aa5502512f43c8f70d77b82c95c7" => :high_sierra
    sha256 "6d4381e011c5a79c89d890e79bb3e94353e2aa5502512f43c8f70d77b82c95c7" => :sierra
    sha256 "6d4381e011c5a79c89d890e79bb3e94353e2aa5502512f43c8f70d77b82c95c7" => :el_capitan
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunit --version").include?(version)
  end
end
