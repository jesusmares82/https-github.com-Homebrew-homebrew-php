require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpmetrics < AbstractPhpPhar
  init
  desc "Static analysis tool for PHP"
  homepage "http://www.phpmetrics.org"
  url "https://github.com/phpmetrics/PhpMetrics/raw/v1.10.0/build/phpmetrics.phar"
  version "1.10.0"
  sha256 "a7aac1115f6ad30365d89655744bb2a3bfed6e798ad30e37ddefd1fa0618da57"

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
