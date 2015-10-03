require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pspell < AbstractPhp56Extension
  init
  homepage "http://php.net/manual/en/book.pspell.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 2
    sha256 "8184fcaaa58fef7646e98655aa59d67a6576e5a748f8839fed3f55b347077962" => :el_capitan
    sha256 "2d06c4fc1d01b0148fbbbd69900a8535076b892af9fc8fce4510ddb9e44ab55e" => :yosemite
    sha256 "4042ff744c201e998619101691421e51292b7b5e7921f425fc8bd9eeebcff789" => :mavericks
  end

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
