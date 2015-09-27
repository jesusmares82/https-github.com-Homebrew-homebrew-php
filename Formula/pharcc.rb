require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Pharcc < AbstractPhpPhar
  init
  desc "tool that converts your php project into a .phar file"
  homepage "https://github.com/cbednarski/pharcc"
  url "https://github.com/cbednarski/pharcc/releases/download/v0.2.3/pharcc.phar"
  version "0.2.3"
  sha256 "9dee4f814aa04bd92a03b5f1aadbef80a567836d310319f4b2775673522fb959"

  test do
    system "pharcc", "--version"
  end
end
