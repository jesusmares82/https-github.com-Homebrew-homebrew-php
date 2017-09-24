require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-6.3.1.phar"
  sha256 "1cb5250aba62933db9fa22446debd0d09bcc758da4dc98daf048773b5fa98ab5"

  bottle do
    cellar :any_skip_relocation
    sha256 "19500995dbb752a7a85f9112066ad0a073a16afbe11a67af7e35106771eeceb1" => :sierra
    sha256 "19500995dbb752a7a85f9112066ad0a073a16afbe11a67af7e35106771eeceb1" => :el_capitan
    sha256 "19500995dbb752a7a85f9112066ad0a073a16afbe11a67af7e35106771eeceb1" => :yosemite
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunit --version").include?(version)
  end
end
