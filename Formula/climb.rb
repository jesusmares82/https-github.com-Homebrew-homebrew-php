require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Climb < AbstractPhpPhar
  init
  desc "Composer version manager tool"
  homepage "https://github.com/vinkla/climb"
  url "https://github.com/vinkla/climb/releases/download/0.6.1/climb.phar"
  sha256 "f5e3711149a321ec35ed71740baa128e7021dd56bde06b971a3ed3cdcfe6bc63"

  test do
    system "climb", "--version"
  end
end
