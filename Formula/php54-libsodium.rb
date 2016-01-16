require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Libsodium < AbstractPhp54Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/1.0.2.tar.gz"
  sha256 "294b82d26eb39123e200eba65fbe207f7a8053049c4ace1e411c264253fafb4f"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    cellar :any
    revision 2
    sha256 "7ef32406e02dc860a13e10bd3dccdf2137e0f8dd2dac0e6aa900f44186fc1f9c" => :el_capitan
    sha256 "85ba7de47b3a7ab6be8cd0a858d0d1b35ba3c03fcd14e5542cc346dc43439bdc" => :yosemite
    sha256 "42fd25a97c68fc11fac11d4b07356187cab1e476f5aee5ae76865a9508c033a4" => :mavericks
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
