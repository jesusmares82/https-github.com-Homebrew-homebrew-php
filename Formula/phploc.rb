require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phploc < AbstractPhpPhar
  init
  desc "Tool for quickly measuring the size of a PHP project"
  homepage "https://github.com/sebastianbergmann/phploc"
  url "https://phar.phpunit.de/phploc-4.0.0.phar"
  sha256 "6b26f5b39e0b54e39892acfd049e7f408fa20b8f12ca8e38a6d01707165a6b95"

  bottle do
    cellar :any_skip_relocation
    sha256 "073c78bc67cade9d40714d241f9b1319141a46b58c54c6fa91706cf17518faf5" => :sierra
    sha256 "12b8e1a331b1c97d18586da0731193ffdafde49eaae1a5a36b7e083849db34b9" => :el_capitan
    sha256 "12b8e1a331b1c97d18586da0731193ffdafde49eaae1a5a36b7e083849db34b9" => :yosemite
  end

  def phar_file
    "phploc-#{version}.phar"
  end

  test do
    system "#{bin}/phploc", "--version"
  end
end
