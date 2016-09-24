require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php71 < AbstractPhp
  init
  desc "PHP Version 7.1"
  bottle do
    sha256 "a92ba720107607a533953b9e8e50b4678d7a3814c134823829ab6423ebc49342" => :el_capitan
    sha256 "05b684059b078d793316c53d66490cd6e42ea4e3dc747fed74a1f99541f0a810" => :yosemite
    sha256 "b0bb37bb71f02abc6e0890143dbb556c0c2f9995703be3578db218c4d6fb454c" => :mavericks
  end

  include AbstractPhpVersion::Php71Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 6

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "7.1"
  end

  def php_version_path
    "71"
  end
end
