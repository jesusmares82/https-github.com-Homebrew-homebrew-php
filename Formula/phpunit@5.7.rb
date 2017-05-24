require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class PhpunitAT57 < AbstractPhpPhar
  init
  desc "(Old stable) Programmer-oriented testing framework for PHP"
  homepage "https://phpunit.de"
  url "https://phar.phpunit.de/phpunit-5.7.20.phar"
  sha256 "012f7fd85ca7b34198fedd4387df453a979bc6240b90da60ad7f3ba41a0d438c"

  bottle do
    cellar :any_skip_relocation
    sha256 "5403afa846ede69cd5eb6308a1912b55aaae70079d5636906781bb9063777081" => :sierra
    sha256 "5fbc1c8fd2009965f454bc8a975791f0d1cf894a402c579651a57119b1d0cfbe" => :el_capitan
    sha256 "5fbc1c8fd2009965f454bc8a975791f0d1cf894a402c579651a57119b1d0cfbe" => :yosemite
  end

  def phar_file
    "phpunit-#{version}.phar"
  end

  test do
    shell_output("#{bin}/phpunitat57 --version").include?(version)
  end
end
