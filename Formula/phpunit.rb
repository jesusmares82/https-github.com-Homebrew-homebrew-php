require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-6.0.7.phar"
  sha256 "e458e71131cc18d0be1945f09d7ad96884cb8ee33e6603c077c5fcdcfc713543"

  bottle do
    cellar :any_skip_relocation
    sha256 "d26c1b4050b69b555377d2453a8026c6d8be74f7a4646a4d9fc93af139742150" => :sierra
    sha256 "d26c1b4050b69b555377d2453a8026c6d8be74f7a4646a4d9fc93af139742150" => :el_capitan
    sha256 "d26c1b4050b69b555377d2453a8026c6d8be74f7a4646a4d9fc93af139742150" => :yosemite
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunit --version").include?(version)
  end
end
