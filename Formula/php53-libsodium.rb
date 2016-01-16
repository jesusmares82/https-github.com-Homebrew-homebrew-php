require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Libsodium < AbstractPhp53Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/1.0.2.tar.gz"
  sha256 "294b82d26eb39123e200eba65fbe207f7a8053049c4ace1e411c264253fafb4f"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    cellar :any
    revision 2
    sha256 "acc80bf6c325c5e993ab95f72121f7549fe94b8ae9d4d6243236255dafcbbd38" => :el_capitan
    sha256 "97ab0dd42cf4500f45edc4360c5679c748bac58c99484a9908bab52bca33ec29" => :yosemite
    sha256 "78f053bef9b54ade10aa180894e2b405af060ffbc5ac8390eed84356c128cd04" => :mavericks
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
