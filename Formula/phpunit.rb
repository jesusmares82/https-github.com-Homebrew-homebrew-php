require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-6.0.7.phar"
  sha256 "e458e71131cc18d0be1945f09d7ad96884cb8ee33e6603c077c5fcdcfc713543"

  bottle do
    cellar :any_skip_relocation
    sha256 "0883cc78ffde43e8e4033c840c0b38dd2b1f09d95fb32f04b0e227e933a63465" => :sierra
    sha256 "0883cc78ffde43e8e4033c840c0b38dd2b1f09d95fb32f04b0e227e933a63465" => :el_capitan
    sha256 "0883cc78ffde43e8e4033c840c0b38dd2b1f09d95fb32f04b0e227e933a63465" => :yosemite
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunit --version").include?(version)
  end
end
