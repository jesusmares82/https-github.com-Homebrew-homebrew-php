require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpmetrics < AbstractPhpPhar
  init
  desc "Static analysis tool for PHP"
  homepage "http://www.phpmetrics.org"
  url "https://github.com/Halleck45/PhpMetrics/raw/v1.8.3/build/phpmetrics.phar"
  version "1.8.3"
  sha256 "454a4d1806bb44cdb2e8535d1a1db051389fd7c140daebce5a8ab2cd78a5fa7f"

  bottle do
    cellar :any_skip_relocation
    sha256 "7ade1c58664fb235c4e423e3bd25833ac3261246a69edb8dfaa04f60c2b2dc94" => :el_capitan
    sha256 "aafe13315ef20ce708d62e53229fb948290279c5980cd2720f8bd8956fc23e33" => :yosemite
    sha256 "23f3ac0d69614338f358c0ea8c9f3acd96ca2243b7a9322cb7a5b49fca6e032a" => :mavericks
  end

  test do
    system "phpmetrics", "--version"
  end
end
