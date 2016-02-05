require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  bottle do
    revision 11
    sha256 "5a9d75aee757c8c087fa3f457801a63aecd3ecd4a65b37d12a5537b4813338e9" => :el_capitan
    sha256 "c090cd2d90ff0e9c0dc3158e0102c03cdab06f57240ae97addd01a0c90e71111" => :yosemite
    sha256 "1f86f4069a93aaeaf1db1bee364e3431686cdd7e2c678968e97926ef1ba47e5a" => :mavericks
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



