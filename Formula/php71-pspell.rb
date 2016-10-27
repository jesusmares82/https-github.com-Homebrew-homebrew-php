require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pspell < AbstractPhp71Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  bottle do
    sha256 "70e99b642160f91e7a4e4f38e228bb126f71b48a50ec01585226a888c39b38f6" => :sierra
    sha256 "079cc792cee19183b6f7271255255a11a76960f0f7344a6d47556ee89ce2e52f" => :el_capitan
    sha256 "1aa26d7e7e72d496292355cd4fa3c6f3ccd10d5f0140d861cb22380e4d116ff5" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 5

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
