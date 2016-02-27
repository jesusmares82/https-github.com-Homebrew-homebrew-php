require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phploc < AbstractPhpPhar
  init
  desc "Tool for quickly measuring the size of a PHP project"
  homepage "https://github.com/sebastianbergmann/phploc"
  url "https://phar.phpunit.de/phploc-3.0.0.phar"
  sha256 "2d5ed6990f056c7cfbfadf03c926b39370ac9afde66747c30f50d2594bff6dca"

  bottle do
    cellar :any_skip_relocation
    sha256 "3567a3c5842bf78cfca11806c615ac7e1bdaef9b345cc779642153f9bfb9f3e1" => :el_capitan
    sha256 "6518adeb9b9c2464ea132d284aa08bc24d5a8ec983df727f823d01d48bd42309" => :yosemite
    sha256 "6518adeb9b9c2464ea132d284aa08bc24d5a8ec983df727f823d01d48bd42309" => :mavericks
  end

  def phar_file
    "phploc-#{version}.phar"
  end

  test do
    system "phploc", "--version"
  end
end
