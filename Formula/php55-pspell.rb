require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Pspell < AbstractPhp55Extension
  init
  homepage "http://php.net/manual/en/book.pspell.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    revision 1
    sha256 "4f5e837aa76036eb8c00e1c65854e7109abf650aef9d00c569b579efa28a6e20" => :yosemite
    sha256 "a38144877def94a5ee396e5dc78fcffe29225c1b2d201ef4fce36dcf17945c30" => :mavericks
    sha256 "4b2acf21f711a9edc5225a5836ce7dad2f875a83e15db881bb824a568273d0f7" => :mountain_lion
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

