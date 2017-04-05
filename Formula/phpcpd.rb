require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpcpd < AbstractPhpPhar
  init
  desc "Copy/Paste Detector (CPD) for PHP code"
  homepage "https://github.com/sebastianbergmann/phpcpd"
  url "https://phar.phpunit.de/phpcpd-3.0.0.phar"
  sha256 "bc03385966b4bd1e62d717cb746c347401b995a23f0f2c0c72bf78016bb039d3"

  bottle do
    cellar :any_skip_relocation
    sha256 "daf019ea51b2eca8394edc7db459a04c29701cffb16761904592f22522542875" => :sierra
    sha256 "dfa30f4c5c5ba8377211265a67c111681225a9ff0434d745d4ebefe6e9fdc36b" => :el_capitan
    sha256 "dfa30f4c5c5ba8377211265a67c111681225a9ff0434d745d4ebefe6e9fdc36b" => :yosemite
  end

  def phar_file
    "phpcpd-#{version}.phar"
  end

  test do
    system "#{bin}/phpcpd", "--version"
  end
end
