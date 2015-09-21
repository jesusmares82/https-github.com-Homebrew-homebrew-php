class Igbinary < Formula
  homepage "https://pecl.php.net/package/igbinary"
  url "https://pecl.php.net/get/igbinary-1.2.1.tgz"
  sha256 "168e51d41a417bbbfe6da0e3cb9b71ef93594f4034f489a951f3b874d03dfdb8"
  head "https://github.com/igbinary/igbinary.git"

  bottle do
    cellar :any
    sha256 "879d7f52a38859cee9abce37e007d5df8e88aa66b5ae3c2bb896ab6a3004f4b6" => :yosemite
    sha256 "8b43bc396c6223789ddb1f96f95ba2b121308683aab020a718be4342e43e9d6e" => :mavericks
    sha256 "483d500cbf87ec7e1bd1fdc0be5995f586d1332a8ab38e559f99debe36c75675" => :mountain_lion
  end

  def install
    Dir.chdir "igbinary-#{version}" unless build.head?

    include.install %w[apc_serializer.h hash.h igbinary.h php_igbinary.h]
  end
end
