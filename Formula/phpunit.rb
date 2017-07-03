require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpunit < AbstractPhpPhar
  init
  desc "Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-6.2.3.phar"
  sha256 "aeaffe1a5a73f72f9e5dd96a5c99b234f1454ade45fae8d46af8693453ecd34d"

  bottle do
    cellar :any_skip_relocation
    sha256 "90eb1f1b365af2ae34e590232ff55de23ac5a53dd074d8098b160cced1319907" => :sierra
    sha256 "8817b063a3222cc897b3e321e41361a35cfc181dea35734562f2719badbe660b" => :el_capitan
    sha256 "8817b063a3222cc897b3e321e41361a35cfc181dea35734562f2719badbe660b" => :yosemite
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunit --version").include?(version)
  end
end
