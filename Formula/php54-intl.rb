require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Intl < AbstractPhp54Extension
  init
  homepage "http://php.net/manual/en/book.intl.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    sha256 "f2b6aee33d186f4d1b680ce35c323e649df25dbfbc7ca3ea19b3a171fa3a121c" => :yosemite
    sha256 "8481cfced3023c6e3b7bd0f7924634c514dc543bee65876a37f390102d220a8c" => :mavericks
    sha256 "759eeac8df88244894af1cf50f093177ba9aa3ea8956168fc1e7af2ca7a342a2" => :mountain_lion
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
                          "--with-icu-dir=#{Formula['icu4c'].prefix}"
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

  test do
    shell_output("php -m").include?("intl")
  end
end

