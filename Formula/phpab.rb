require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpab < AbstractPhpPhar
  init
  desc "Lightweight php namespace aware autoload generator"
  homepage "https://github.com/theseer/Autoload"
  url "https://github.com/theseer/Autoload/releases/download/1.22.0/phpab-1.22.0.phar"
  sha256 "829200ce8d507291964284b4bcd37d1e35c61790d0b399174a6574e411479cbf"

  bottle :unneeded

  def phar_file
    "phpab-#{version}.phar"
  end

  test do
    system "phpab", "--version"
  end
end
