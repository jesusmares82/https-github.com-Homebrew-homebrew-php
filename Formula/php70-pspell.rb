require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  bottle do
    revision 10
    sha256 "12e940f6de7a604d4ea1e01dbe2cbe33f3688978c3bebc3cb6a40a65e1dae5fb" => :el_capitan
    sha256 "f517d3b01544f7ee86f941578835fdc5b9de75e8e9c6a9f17aa0051519afaaac" => :yosemite
    sha256 "acb25fc0fbfe562e996a2232eca09f0ff79ccba09a139253f032b527f9c781f4" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "aspell"

  def install
    Dir.chdir "ext/pspell"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--with-pspell=#{Formula["aspell"].opt_prefix}"
    system "make"
    prefix.install "modules/pspell.so"
    write_config_file if build.with? "config-file"
  end
end


