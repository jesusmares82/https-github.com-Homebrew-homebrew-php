require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpcpd < AbstractPhpPhar
  init
  desc "Copy/Paste Detector (CPD) for PHP code"
  homepage "https://github.com/sebastianbergmann/phpcpd"
  url "https://phar.phpunit.de/phpcpd-3.0.0.phar"
  sha256 "bc03385966b4bd1e62d717cb746c347401b995a23f0f2c0c72bf78016bb039d3"

  bottle do
    cellar :any_skip_relocation
    sha256 "e8b3ce1d18fb6002f9869290c97600e5737adeab348f0141d3af4839671e5af6" => :sierra
    sha256 "201ca00a23c810187c5b348979ac24e32f384ac86995f648ebf170884443a252" => :el_capitan
    sha256 "981f0a1a34c144f4ff5f7c3693b990bdc8b55bea35dcad135db6f2331050b304" => :yosemite
    sha256 "087aae9a8aa00fdee9da8379c3d99cbeb9a6b17215064f37e8515d02549275ad" => :mavericks
  end

  def phar_file
    "phpcpd-#{version}.phar"
  end

  test do
    system "#{bin}/phpcpd", "--version"
  end
end
