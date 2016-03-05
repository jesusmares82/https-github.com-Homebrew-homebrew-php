require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Pdepend < AbstractPhpPhar
  init
  desc "performs static code analysis"
  homepage "http://pdepend.org/"
  url "http://static.pdepend.org/php/2.2.3/pdepend.phar"
  sha256 "44e33a0a604be33e6fe0016791bb842a83c02754c4067745d70b5195c14825ab"

  bottle do
    cellar :any_skip_relocation
    sha256 "33b23b22dd8ea627fbf68bec2cd410dc6dc187223a838945a3ccf2e4e76f9e3d" => :el_capitan
    sha256 "548af8829d08c0407c4c3a3f5cd7bfde7336e38811276126bc4e5ddef011a8c8" => :yosemite
    sha256 "59cc3cd71a9e6d65d15bd27a36c793da2443720eb2a4dcdf24c12a3fbd5ac153" => :mavericks
  end

  test do
    system "pdepend", "--version"
  end
end
