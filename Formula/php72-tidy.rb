require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Tidy < AbstractPhp72Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision 10

  bottle do
    sha256 "4d7a4fdd17a8748ded1a4ab854b4ad5d1a474dfc52ad16197dee155dcd852f35" => :high_sierra
    sha256 "e36b6f9ab3ce4608965cfabe561ac18a158609591f11e6fce6e6ef894833b337" => :sierra
    sha256 "38e9dba072c49e8ff910cb9e811fd14017eafe07899f9b4c7c64b37619604d1d" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

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
