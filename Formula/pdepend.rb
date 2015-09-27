require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Pdepend < AbstractPhpPhar
  init
  desc "performs static code analysis"
  homepage "http://pdepend.org/"
  url "http://static.pdepend.org/php/2.0.6/pdepend.phar"
  sha256 "71573a4b125a5e1ca42032af52095b2d96a39aafb26704529549c42d6833bf4f"

  test do
    system "pdepend", "--version"
  end
end
