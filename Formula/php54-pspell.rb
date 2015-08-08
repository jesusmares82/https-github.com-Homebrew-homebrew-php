require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Pspell < AbstractPhp54Extension
  init
  homepage "http://php.net/manual/en/book.pspell.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    sha256 "11539f81e7d026e1db59924fea3ce8086d6d94bd5b1c7fa3c6a1cd566655705a" => :yosemite
    sha256 "34b831c42f0ee9030998e3ba9d812c6b7f9fd0120834842bd7a83c14a5665510" => :mavericks
    sha256 "596316693d58ed7f98d1d4139074a0d1bc025bbac762effa68bec5d63960a4bb" => :mountain_lion
  end

  depends_on "aspell"

  def install
    Dir.chdir "ext/pspell"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--with-pspell=#{Formula['aspell'].opt_prefix}"
    system "make"
    prefix.install "modules/pspell.so"
    write_config_file if build.with? "config-file"
  end
end

