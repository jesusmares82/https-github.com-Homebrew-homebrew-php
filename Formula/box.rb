require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Box < AbstractPhpPhar
  init
  desc "application for building and managing Phars"
  homepage "https://box-project.github.io/box2/"
  url "https://github.com/box-project/box2/releases/download/2.5.3/box-2.5.3.phar"
  sha256 "95a3098b27c15939cbad9bba72c07cf4d425a760e979117ab3279e7ac209cfeb"

  def phar_file
    "box-#{version}.phar"
  end

  test do
    system "box", "--version"
  end
end
