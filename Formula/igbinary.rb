class Igbinary < Formula
  homepage "http://pecl.php.net/package/igbinary"
  url "http://pecl.php.net/get/igbinary-1.2.1.tgz"
  sha256 "168e51d41a417bbbfe6da0e3cb9b71ef93594f4034f489a951f3b874d03dfdb8"
  head "https://github.com/igbinary/igbinary.git"

  bottle do
  end

  def install
    Dir.chdir "igbinary-#{version}" unless build.head?

    include.install %w[apc_serializer.h hash.h igbinary.h php_igbinary.h]
  end
end

