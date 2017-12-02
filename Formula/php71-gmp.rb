require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Gmp < AbstractPhp71Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision 17

  bottle do
    sha256 "69c56fe21ceaa0c4e79cd867ae34258c6d67fa2805d525e8d34060e13abe8c19" => :high_sierra
    sha256 "9b8ae0e3bcfa64ae4a7f27e0a08057e31e26f3c95c8bd80455ad13bf8a70f8ec" => :sierra
    sha256 "2c67dbcdfe78c3ea0d1ff75ff6f679d1114a7e3d663952f7bac870d372f3a75f" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

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
