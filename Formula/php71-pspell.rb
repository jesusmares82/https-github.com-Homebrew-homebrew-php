require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pspell < AbstractPhp71Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  revision 14

  bottle do
    sha256 "1c9bf2eefbbda6dfe007e6cbe7fd1287f72c4ca1698f30ca20453d06518aa5a4" => :sierra
    sha256 "d8f6208aca746b32112cdc5f6ca0a1f1d14fff2be3a3109abd9dc2cc86d7c696" => :el_capitan
    sha256 "10f7c6ca91517563e3e9993aa57dd5ebfc881205d3230959f5b54dbddcdcd343" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "aspell"

  def install
    Dir.chdir "ext/pspell"

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
