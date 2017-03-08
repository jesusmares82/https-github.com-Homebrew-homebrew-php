require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-6.0.8.phar"
  sha256 "6f20600685aad19c44dbfb5423277c215b1efbb62a599048ac46937a75116822"

  bottle do
    cellar :any_skip_relocation
    sha256 "b766e0e8c4146a33b28270dcfa68fe2941cefeb7a02d110f979d2cbbcd347d9a" => :sierra
    sha256 "b766e0e8c4146a33b28270dcfa68fe2941cefeb7a02d110f979d2cbbcd347d9a" => :el_capitan
    sha256 "b766e0e8c4146a33b28270dcfa68fe2941cefeb7a02d110f979d2cbbcd347d9a" => :yosemite
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunit --version").include?(version)
  end
end
