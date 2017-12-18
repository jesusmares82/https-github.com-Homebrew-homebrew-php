require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class PhpunitAT57 < AbstractPhpPhar
  init
  desc "(Old stable) Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.7.26.phar"
  sha256 "5483b06864e375ffaff506888a2ff6480561345f5a2b8d88b6d5896b89a249af"

  bottle do
    cellar :any_skip_relocation
    sha256 "ef9dca091ddba0a1be862350118e4c41e0800668de19a1363ec67dc50ae5d3cc" => :high_sierra
    sha256 "ef9dca091ddba0a1be862350118e4c41e0800668de19a1363ec67dc50ae5d3cc" => :sierra
    sha256 "ef9dca091ddba0a1be862350118e4c41e0800668de19a1363ec67dc50ae5d3cc" => :el_capitan
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunitat57 --version").include?(version)
  end
end
