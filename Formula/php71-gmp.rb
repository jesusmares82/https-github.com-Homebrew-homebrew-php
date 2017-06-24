require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Gmp < AbstractPhp71Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  revision 12

  bottle do
    sha256 "a3fb9f5a08227579f6588ccff127c4de4c7f8b7c71e904895addc92572b345f5" => :sierra
    sha256 "fb993bc615da3d8c1b10f161f8e47a4c489a19556859d580fe59e41b0cb0d804" => :el_capitan
    sha256 "af51403171358e8c6d3e95ca46a9e788ac1b8927dc0c5549f477ce06d3f27900" => :yosemite
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
