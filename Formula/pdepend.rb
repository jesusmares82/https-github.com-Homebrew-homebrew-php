require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Pdepend < AbstractPhpPhar
  init
  desc "performs static code analysis"
  homepage "https://pdepend.org"
  url "https://static.pdepend.org/php/2.5.0/pdepend.phar"
  sha256 "0f632ea6d7ab26deabcb9f6a95c337fdd5fbba2199e4aef93ff18a759dec4999"

  bottle do
    cellar :any_skip_relocation
    sha256 "2c5bf14d987656c4329b3254db3eadc447b4df2906dac9684b5e24fcb5aea643" => :sierra
    sha256 "33b23b22dd8ea627fbf68bec2cd410dc6dc187223a838945a3ccf2e4e76f9e3d" => :el_capitan
    sha256 "548af8829d08c0407c4c3a3f5cd7bfde7336e38811276126bc4e5ddef011a8c8" => :yosemite
    sha256 "59cc3cd71a9e6d65d15bd27a36c793da2443720eb2a4dcdf24c12a3fbd5ac153" => :mavericks
  end

  test do
    system "#{bin}/pdepend", "--version"
  end
end
