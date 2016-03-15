require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Gmp < AbstractPhp55Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 5
    sha256 "047aba24149036da04a20df7ebcebbfc120058aff3cb380cf73a7bbae982bb1f" => :el_capitan
    sha256 "e3049c53c69adc1cc442f4442be96a48abdf38261f043dc36bcc613c093ab606" => :yosemite
    sha256 "56e46d0d2d76bb7cad01a1c11de8da8ef816e2ff461856bb75f56a8ff513222a" => :mavericks
  end

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



