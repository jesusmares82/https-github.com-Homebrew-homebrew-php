require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  bottle do
    revision 8
    sha256 "ab7020c5714e0acd5d13aec43e05b48efa83e1ef67f3f5d82883daeb14147fcc" => :el_capitan
    sha256 "e59423ab22d78f33b118c090322966289d82629e3c181c88775f00c5629709e0" => :yosemite
    sha256 "3bced194b73c856c40575148b4cd958c62b5352174d289866ba59aeb526d2a77" => :mavericks
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
