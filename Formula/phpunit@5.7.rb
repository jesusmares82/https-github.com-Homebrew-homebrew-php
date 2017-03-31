require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class PhpunitAT57 < AbstractPhpPhar
  init
  desc "(Old stable) Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.7.17.phar"
  sha256 "2d8ceed912469b359758249b584ed9b14382be0809d30f5bb96d4949e6e850b3"

  bottle do
    cellar :any_skip_relocation
    sha256 "cee1dd3c1b282efc57724a4df27dffa6608ceb44b3e6b41d0a2d27c7b75fe8f6" => :sierra
    sha256 "cee1dd3c1b282efc57724a4df27dffa6608ceb44b3e6b41d0a2d27c7b75fe8f6" => :el_capitan
    sha256 "cee1dd3c1b282efc57724a4df27dffa6608ceb44b3e6b41d0a2d27c7b75fe8f6" => :yosemite
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunitat57 --version").include?(version)
  end
end
