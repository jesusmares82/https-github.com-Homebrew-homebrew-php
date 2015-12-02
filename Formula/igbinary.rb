class Igbinary < Formula
  desc "Igbinary is a drop in replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://pecl.php.net/get/igbinary-1.2.1.tgz"
  sha256 "168e51d41a417bbbfe6da0e3cb9b71ef93594f4034f489a951f3b874d03dfdb8"
  head "https://github.com/igbinary/igbinary.git"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "634d3f7193996f225520d30366567680a50ac51a6ebbef923f194f8ce70a5955" => :el_capitan
    sha256 "5a38a58cfb7ca2749a478c9efb329e55b5bd9e9157d0874d672eed5a4a369cc4" => :yosemite
    sha256 "34d8a2aa98964de408be73d2a79eba66114dfe9fc04643e69d3c0cff372bfed3" => :mavericks
  end

  def install
    Dir.chdir "igbinary-#{version}" unless build.head?

    include.install %w[apc_serializer.h hash.h igbinary.h php_igbinary.h]
  end
end
