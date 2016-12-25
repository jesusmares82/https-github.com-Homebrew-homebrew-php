require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpab < AbstractPhpPhar
  init
  desc "Lightweight php namespace aware autoload generator"
  homepage "https://github.com/theseer/Autoload"
  url "https://github.com/theseer/Autoload/releases/download/1.23.0/phpab-1.23.0.phar"
  sha256 "c28962d642414f38051f40eac062edc8d7ae376ab95b6e01a71f7b4ddeef21c5"

  bottle :unneeded

  def phar_file
    "phpab-#{version}.phar"
  end

  test do
    system "#{bin}/phpab", "--version"
  end
end
