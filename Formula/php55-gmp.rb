require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Gmp < AbstractPhp55Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 7
    sha256 "b85d9a52c5f8120047e01f5e13ee14ed842b402a9218c1a96daf861715e7fe07" => :el_capitan
    sha256 "3b312493982859c4ea1af847960ffdb5d3dfc8f249ca12ddb51ae2055ae00a88" => :yosemite
    sha256 "7673be375eaa2fa10be8e6e358e96c8019fb00b593333acba1833aa06497b7ac" => :mavericks
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






