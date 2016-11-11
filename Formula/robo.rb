require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Robo < AbstractPhpPhar
  init
  desc "Modern Task Runner for PHP"
  homepage "http://robo.li/"
  url "https://github.com/consolidation/Robo/releases/download/1.0.5/robo.phar"
  sha256 "863b4ac9594e58f6dc822a7b18673e053f8763910c6ef2b29b453d20483e74f7"

  bottle :unneeded

  def phar_file
    "robo.phar"
  end

  def phar_bin
    "robo"
  end

  test do
    system "#{bin}/robo", "--version"
  end
end
