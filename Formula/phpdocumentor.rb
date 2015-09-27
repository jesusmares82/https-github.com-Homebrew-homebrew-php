require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpdocumentor < AbstractPhpPhar
  init
  desc "Documentation Generator for PHP"
  homepage "http://www.phpdoc.org"
  url "https://github.com/phpDocumentor/phpDocumentor2/releases/download/v2.8.5/phpDocumentor.phar"
  version "2.8.5"
  sha256 "7613a3d6ffc182595b7423bc2373cd215cac269135f4b0f973e5c1b617b565b7"

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
