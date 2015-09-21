require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 2
    sha256 "e7f761e55f079a82d59cd7868d98b4fef3c0fab562f13e8bb918cd78379ea262" => :el_capitan
    sha256 "8075199da55efc4a981047b73ecf144c3829ef1e2e31d5e80400c751bb52e89b" => :yosemite
    sha256 "9942a61e507366c404a8e43386d3c65198f5024b0a7b363a940a9653fbc97f4e" => :mavericks
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
