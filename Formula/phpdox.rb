require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phpdox < AbstractPhpPhar
  init
  desc "Documentation generator for PHP"
  homepage "https://github.com/theseer/phpdox"
  url "https://github.com/theseer/phpdox/releases/download/0.8.1.1/phpdox-0.8.1.1.phar"
  sha256 "1424d4603e0fdb0c80e39266fb832060bffbcc665a8c8d29b411e88d096d5da2"

  def phar_file
    "phpdox-#{version}.phar"
  end

  test do
    system "phpdox", "--version"
  end
end
