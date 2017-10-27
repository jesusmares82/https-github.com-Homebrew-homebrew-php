require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Gmp < AbstractPhp71Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision 16

  bottle do
    sha256 "aba0ed2d88aa21e649abf6ab341229388cdd981887e8c6e4887c9ac6b0183497" => :high_sierra
    sha256 "1f5163a9b778cb5aef06da29d77345bb00d3231f5c3d56a3bdcc83b7444cf26b" => :sierra
    sha256 "5562fe99a658886a122ed621a27802de22606fbb7e09b8e77141e76aedb1c109" => :el_capitan
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
