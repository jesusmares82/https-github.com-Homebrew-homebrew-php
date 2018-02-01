require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Gmp < AbstractPhp72Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision 10

  bottle do
    sha256 "a901ed57bf111d760e200b45c5da6c0023ed1f9945d7acaeb3bd3eda1c8d75e6" => :high_sierra
    sha256 "60707b5b410c01c1e9a72a1176a5c50aecd8b5de7767b931e870b18ee57c7f29" => :sierra
    sha256 "e579b66f1889adba8370cfb5877591a57b782e154026e906f998ea6aa01f53aa" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "gmp"

  def install
    Dir.chdir "ext/gmp"

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
