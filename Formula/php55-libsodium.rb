require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Libsodium < AbstractPhp55Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/0.1.3.tar.gz"
  sha256 "cf7314420f270eeef207add6f44c3bdd88b6c6395402d14b9d37ce2171bca734"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    cellar :any
    revision 1
    sha256 "434bf1b766520def13b509a2fc26aab6843b5f453c883299fde3e201cdd46461" => :el_capitan
    sha256 "25eb9fa3c18712efcf9b7bfeda48a31118752bc4b5b3ca1ca444c84ead1165af" => :yosemite
    sha256 "776a75e1461a33ea9ebbc86c47ddb5f4729d81ee46e8600687acc9feecfebfe6" => :mavericks
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
