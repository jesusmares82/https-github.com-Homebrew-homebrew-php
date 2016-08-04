require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpdocumentor < AbstractPhpPhar
  init
  desc "Documentation Generator for PHP"
  homepage "http://www.phpdoc.org"
  url "https://github.com/phpDocumentor/phpDocumentor2/releases/download/v2.9.0/phpDocumentor.phar"
  version "2.9.0"
  sha256 "c7dadb6af3feefd4b000c19f96488d3c46c74187701d6577c1d89953cb479181"

  bottle do
    cellar :any_skip_relocation
    sha256 "0f24a1abe5c60136e48306d2c5f5eb4d15ad6a6bf0452b8700fa7721f2360ae7" => :el_capitan
    sha256 "18b204214c4ede0c9168a34de3c0d4e027e973a55e2970dedc45f0221d12bd72" => :yosemite
    sha256 "4088595dbb230758f752da3a455984eff08d1188c7b6e8f9ced372d43ed2b270" => :mavericks
  end

  def phar_file
    "phpDocumentor.phar"
  end

  def phar_bin
    "phpdoc"
  end

  test do
    system "phpdoc", "--version"
  end
end
