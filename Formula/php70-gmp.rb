require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  bottle do
    revision 10
    sha256 "92fce5a20ebacecac0d20323dbcdf1e667d7244a2309fc3dee2c7ff8da5898ca" => :el_capitan
    sha256 "19b8d425db81c77242dd487e36384464b5ef46ed94c607a2b56a81a3fabdb68c" => :yosemite
    sha256 "48a415e1a10746553991c9c564351f5912718cb229a25c4db2152db72fed7c59" => :mavericks
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


