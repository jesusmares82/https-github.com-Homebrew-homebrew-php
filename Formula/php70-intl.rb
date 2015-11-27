require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Intl < AbstractPhp70Extension
  init
  desc "A wrapper for the ICU library"
  homepage "http://php.net/manual/en/book.intl.php"
  bottle do
    revision 7
    sha256 "bd494982eeaf56be831b7c6cce357aa507bc5726de9fc0efa81c410c0f394ff8" => :el_capitan
    sha256 "3d82bdf3b9d0ac8467bac1b6f8625e5a4b3976fdb2563e65bb497ae4a8a69d85" => :yosemite
    sha256 "4ecd3d46cfaf31d9d3491b23268822e5ec7e13dff479b279d067c7d44b14f55d" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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
