require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpab < AbstractPhpPhar
  init
  desc "Lightweight php namespace aware autoload generator"
  homepage "https://github.com/theseer/Autoload"
  url "https://github.com/theseer/Autoload/releases/download/1.21.0/phpab-1.21.0.phar"
  sha256 "892cbbeb1ddf41c1df82864ea63f55a34d6b09f5e671f6d704fd79d3cbb5b959"

  bottle :unneeded

  def phar_file
    "phpab-#{version}.phar"
  end

  test do
    system "phpab", "--version"
  end
end
