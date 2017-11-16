require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpcpd < AbstractPhpPhar
  init
  desc "Copy/Paste Detector (CPD) for PHP code"
  homepage "https://github.com/sebastianbergmann/phpcpd"
  url "https://phar.phpunit.de/phpcpd-3.0.1.phar"
  sha256 "47ff2771b952578c4664dec631dc8720bb3f51f707e13ec9a9d52857b7b63c37"

  bottle do
    cellar :any_skip_relocation
    sha256 "81d791d99104fd8fb5bcd79fe8de93081fc98c9629c58a1c90c7b30d17278df5" => :high_sierra
    sha256 "81d791d99104fd8fb5bcd79fe8de93081fc98c9629c58a1c90c7b30d17278df5" => :sierra
    sha256 "81d791d99104fd8fb5bcd79fe8de93081fc98c9629c58a1c90c7b30d17278df5" => :el_capitan
  end

  def phar_file
    "phpcpd-#{version}.phar"
  end

  test do
    system "#{bin}/phpcpd", "--version"
  end
end
