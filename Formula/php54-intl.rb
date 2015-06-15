require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Intl < AbstractPhp54Extension
  init
  homepage "http://php.net/manual/en/book.intl.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "5d0bbf10273205549a378e1ffc6e236241ecbde2eb025ac8f59ce8a1352604c3" => :yosemite
    sha256 "e0c4407f8166262af445640208f3d3c28f8f60526bf4e58fbf6b9405b3f6abcc" => :mavericks
    sha256 "7545b19e8c0ef7799cfcf0df261f14fa54fec1b6216dd67360670a667ae62e26" => :mountain_lion
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
