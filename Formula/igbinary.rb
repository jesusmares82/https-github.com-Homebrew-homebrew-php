class Igbinary < Formula
  desc "Drop in replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.3.tar.gz"
  sha256 "af1f19dbf64e37311099e444f2121b917349cc104abc858e34b094d1a296e179"
  head "https://github.com/igbinary/igbinary.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "894600fe5f6ce3ddc0a82735ec55d4b604b06522a7bc600048a207961083c11c" => :sierra
    sha256 "e3cd7a457e0683b90be092a064d7768b4702aabb51d2b6d6bb261dc4568a15eb" => :el_capitan
    sha256 "e3cd7a457e0683b90be092a064d7768b4702aabb51d2b6d6bb261dc4568a15eb" => :yosemite
  end

  def install
    include.install Dir["src/*"]
  end
end
