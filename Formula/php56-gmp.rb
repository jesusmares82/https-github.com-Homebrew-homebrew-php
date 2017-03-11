require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Gmp < AbstractPhp56Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 3

  bottle do
    sha256 "7b8310fd17a9b03d38c48d2ba5227aa651299a08f4f83345669b7366d42aac7d" => :sierra
    sha256 "bc40ceb542be38f9dba3d77d2c26b6296b7fa22f23d0b1daebb7da5d15eda26a" => :el_capitan
    sha256 "c0eb01ab53609c71e42177dc81c8138c75232d588e20599696918b046cc07e42" => :yosemite
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
