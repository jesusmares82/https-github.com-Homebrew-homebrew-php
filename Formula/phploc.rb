require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phploc < AbstractPhpPhar
  init
  desc "Tool for quickly measuring the size of a PHP project"
  homepage "https://github.com/sebastianbergmann/phploc"
  url "https://phar.phpunit.de/phploc-2.0.2.phar"
  sha256 "0ce805f48d778c49ae78af0b08a16efd2eba01ff31aa59e5374fad27e93c5558"

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
