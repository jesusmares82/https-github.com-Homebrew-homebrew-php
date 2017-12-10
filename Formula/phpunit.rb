require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-6.5.4.phar"
  sha256 "a09e696f232a7008c21e02f38b437136d99d80b179666721e42fd53e8b86de27"

  bottle do
    cellar :any_skip_relocation
    sha256 "806639f8503c71f6f65464ef0172009f07dad9db62a16e1eed3c3d8155a3f52b" => :high_sierra
    sha256 "806639f8503c71f6f65464ef0172009f07dad9db62a16e1eed3c3d8155a3f52b" => :sierra
    sha256 "806639f8503c71f6f65464ef0172009f07dad9db62a16e1eed3c3d8155a3f52b" => :el_capitan
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunit --version").include?(version)
  end
end
