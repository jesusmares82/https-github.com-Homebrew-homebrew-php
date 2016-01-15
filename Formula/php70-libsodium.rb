require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Libsodium < AbstractPhp70Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/1.0.2.tar.gz"
  sha256 "294b82d26eb39123e200eba65fbe207f7a8053049c4ace1e411c264253fafb4f"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    cellar :any
    revision 3
    sha256 "8cdfc6db6978537a4ffcd795c67ede2fee4efd7918df7ba04135e410a00ea514" => :el_capitan
    sha256 "76fdfe7a07216622ac8ce10b494be661a0732cbed89532daf87d18a09a8b78a6" => :yosemite
    sha256 "eb2bcdbe55198d333ea638385fa85397ae9e396e8ab769a461469e9b4c18cbeb" => :mavericks
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
