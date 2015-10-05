require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  bottle do
    revision 3
    sha256 "809c651ec79910bceafed41b1938cbde5779c535977fc99baebe5cc5f757860d" => :el_capitan
    sha256 "ad8a3738640f76126ff70dd6e4e2aa52b2c0d3e8670c2183441b5fe1a93fe8fc" => :yosemite
    sha256 "b6cff065026659d6b8d5c86622821a5b1864e30f40689be06b16c3647f344926" => :mavericks
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
