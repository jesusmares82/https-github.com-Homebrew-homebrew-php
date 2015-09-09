require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Gmp < AbstractPhp55Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 1
    sha256 "442c3bfe2527d4eb1f5600006a364297999ccd82884c34386cb18bdf289fd4eb" => :yosemite
    sha256 "0f2f30075ec253548f4c9ebb8d3d846c5f945d2090422d4ce0b5bae0ac364544" => :mavericks
    sha256 "b8e1bf49e99ff076d5d3ff6a4a2ffda62c62d6d2775bfd7222eb795977d6cbc1" => :mountain_lion
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

  test do
    shell_output("php -m").include?("gmp")
  end
end
