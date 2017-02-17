require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pspell < AbstractPhp71Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  revision 9

  bottle do
    sha256 "55256f540aac246290a38a64256e96832c9e28a42cae657085da580e6edc8651" => :sierra
    sha256 "3a3830227df388bce202278e6c40c6f8995b3ff1534160bcd57dcbfed8fa721e" => :el_capitan
    sha256 "c0c325683ecd7506faf4c9a35112b8437dd874d12b877003739f2731193accca" => :yosemite
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
