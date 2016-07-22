require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Gmp < AbstractPhp56Extension
  init
  desc "GMP core php extension"
  homepage "http://php.net/manual/en/book.gmp.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 11
    sha256 "adaa471161d8c1b0ccb34ca96696d25003ac1f1dfd013e7174707d992ff4e9bf" => :el_capitan
    sha256 "ed92bb4907fb2852fbd4dc6da4339061a031e20c6befba95792c90f2ec0cc0a4" => :yosemite
    sha256 "414237c91710d7e829b559635b5b58c1d1948e501ab6c8d18565e8950f620d5b" => :mavericks
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








