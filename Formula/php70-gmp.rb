require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  bottle do
    sha256 "13b45e51cc8338c8cf69dd222d1a7f3b07a08776141af7127883ded61f6e482b" => :el_capitan
    sha256 "6d2f22221566eeea8e669d84b55c61cda408efb98da06b1028ef1500bef9281f" => :yosemite
    sha256 "dc348e3e9a9165b34726a6852c7b2a2e4d9a892de507a68d59f71e740fcd5426" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "gmp"

  def install
    Dir.chdir "ext/gmp"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                           "--with-gmp=#{Formula["gmp"].opt_prefix}"
    system "make"
    prefix.install "modules/gmp.so"
    write_config_file if build.with? "config-file"
  end
end





