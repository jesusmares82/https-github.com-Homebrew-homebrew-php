require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  revision 8

  bottle do
    sha256 "ed4a764e49c055a864e196331e6993ae5e4773f304e04a41aa970d39edb60c29" => :sierra
    sha256 "e85c385886679aa0fbebc2489b1eea6bed7ec7de19dea64232637422f3019d34" => :el_capitan
    sha256 "2fc282bdfecc330a81e0428d2ef6c9d052296805c9f27aeebb074de1a42983fa" => :yosemite
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
