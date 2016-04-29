require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  bottle do
    revision 13
    sha256 "0858d101e97f11eb52e9eed1aea37491ee943724cbdaaad19712dac4f4deddf2" => :el_capitan
    sha256 "d21f3d14030c39000dbf7362545ab40e109a9a324f7c3e7c1bba2f5434fbea52" => :yosemite
    sha256 "c5e3af9ed716b89d7896329e96cc92e596f815c79408b453e6d16758cdb596c2" => :mavericks
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






