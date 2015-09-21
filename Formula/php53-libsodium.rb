require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Libsodium < AbstractPhp53Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/0.1.3.tar.gz"
  sha256 "cf7314420f270eeef207add6f44c3bdd88b6c6395402d14b9d37ce2171bca734"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    cellar :any
    revision 1
    sha256 "2b35158e174a9d45dd94f87181f49d625b72d22a1add8dc76f08c32d97f6f3d2" => :el_capitan
    sha256 "931a3791f235ff5d625e53652aecedf768fba20241a8b58252fa9fbf9e4fee44" => :yosemite
    sha256 "91cf8045af8f0e41574030925284bd3ad9695d2f4c32ab1d7c54b3bc110a2cbe" => :mavericks
  end

  depends_on "libsodium"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/libsodium.so"
    write_config_file if build.with? "config-file"
  end
end
