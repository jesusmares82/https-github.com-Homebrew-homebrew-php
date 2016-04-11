require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Intl < AbstractPhp53Extension
  init
  desc "A wrapper for the ICU library"
  homepage "http://php.net/manual/en/book.intl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 1

  bottle do
    revision 1
    sha256 "d164189f721e3eca36490358e60086038323ff903d105054d548999c7d2ab8a1" => :el_capitan
    sha256 "004111bfdc080cf29a424d6d8d51f1267790c9c858b6bb06298ee8f4a34defe7" => :yosemite
    sha256 "4380fe5af7e9c8ee3d0ca23edf17ec84ee5be04894e469bc464b6784b060ebb6" => :mavericks
  end

  depends_on "icu4c"

  def install
    Dir.chdir "ext/intl"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--enable-intl",
                          "--with-icu-dir=#{Formula["icu4c"].prefix}"
    system "make"
    prefix.install "modules/intl.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<-EOS.undent

      ;intl.default_locale =
      ; This directive allows you to produce PHP errors when some error
      ; happens within intl functions. The value is the level of the error produced.
      ; Default is 0, which does not produce any errors.
      ;intl.error_level = E_WARNING
    EOS
  end
end
