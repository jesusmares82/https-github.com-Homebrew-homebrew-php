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
    revision 2
    sha256 "e67e176388d5c4b0a1a45967cdbf5d870ca739d18bd881e5ae8df2b49082f9a0" => :el_capitan
    sha256 "f0c92ee7a2be32958913b1ce2c330f378401095e56cf4bba2c3011721c10b064" => :yosemite
    sha256 "238835a87685ade190cacbdac0e6d6b870dc066963598ff6e5c0d38ee09f9df3" => :mavericks
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
