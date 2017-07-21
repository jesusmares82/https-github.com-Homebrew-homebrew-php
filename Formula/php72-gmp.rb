require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Gmp < AbstractPhp72Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  revision 1

  bottle do
    sha256 "afecb543ad4e87d25614ddc092520b20863a5b4a44ecc76ec6114d4cc6b499f2" => :sierra
    sha256 "89100030fa7c560ce1d90c9f0cc6e7fd525fa2b42c49e5c2f87565331b55dc8b" => :el_capitan
    sha256 "6668a5949578be7d772277421cc3e7a038299b93a39b420306ed983ca787d83c" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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
