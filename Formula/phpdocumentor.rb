require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpdocumentor < AbstractPhpPhar
  init
  desc "Documentation Generator for PHP"
  homepage "http://www.phpdoc.org"
  url "https://github.com/phpDocumentor/phpDocumentor2/releases/download/v2.8.5/phpDocumentor.phar"
  version "2.8.5"
  sha256 "7613a3d6ffc182595b7423bc2373cd215cac269135f4b0f973e5c1b617b565b7"

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
