require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Libsodium < AbstractPhp55Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/1.0.2.tar.gz"
  sha256 "294b82d26eb39123e200eba65fbe207f7a8053049c4ace1e411c264253fafb4f"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    cellar :any
    sha256 "aad7d4115656197b0bc7616c1ba9f1b2ce9b59dbb4174bbc4b404761ae4cd346" => :el_capitan
    sha256 "84119439991188a0b07d06235c1525bc77b0cb6283f604d5031fc723ad1c8f2c" => :yosemite
    sha256 "0f8767d5c07a0fb67723a470dc78e17ffda407a39a16a70e619395cdfc57bd39" => :mavericks
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
