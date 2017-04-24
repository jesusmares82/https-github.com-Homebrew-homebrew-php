class Igbinary < Formula
  desc "Drop in replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.4.tar.gz"
  sha256 "7b71e60aeada2b9729f55f3552da28375e3c5c66194b2c905af15c3756cf34c8"
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
