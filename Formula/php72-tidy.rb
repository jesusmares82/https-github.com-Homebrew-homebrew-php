require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Tidy < AbstractPhp72Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  revision 2

  bottle do
    sha256 "f06ab26bce66e14354f556e998290a3b3c2afb5214227c5f5f0f5ca23f6d2b73" => :sierra
    sha256 "32ca22550349a3218ba7559a74effab13640e5ffbde1bfbe46d0a0db29e63998" => :el_capitan
    sha256 "52587d32540663c3b33692750d769a76c9eed7bb32eae2d71ccb81cf8c6764cc" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "tidy-html5"

  def install
    Dir.chdir "ext/tidy"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-tidy=#{Formula["tidy-html5"].opt_prefix}"
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file if build.with? "config-file"
  end
end
