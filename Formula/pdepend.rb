require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Pdepend < AbstractPhpPhar
  init
  desc "performs static code analysis"
  homepage "http://pdepend.org/"
  url "http://static.pdepend.org/php/2.0.6/pdepend.phar"
  sha256 "71573a4b125a5e1ca42032af52095b2d96a39aafb26704529549c42d6833bf4f"

  bottle do
    cellar :any_skip_relocation
    sha256 "cbdd9eeb414aed98d892bfdc6f3eed7e8a89026489637f5884dee4d7ac791b13" => :el_capitan
    sha256 "fbdb91a2a3735d420d911c2f0e81a55da6635bcedf11df202faca53b700e2880" => :yosemite
    sha256 "b6a8c44081c8cd1d262d48cc20e153e4d2e131389cf464054a595a16b29647bd" => :mavericks
  end

  test do
    system "pdepend", "--version"
  end
end
