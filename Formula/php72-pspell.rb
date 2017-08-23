require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Pspell < AbstractPhp72Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  revision 3

  bottle do
    sha256 "deae766fe6b5d17fd57c4dc525719ffd3807fa51ee49206752e4fcfcfc9cce0f" => :sierra
    sha256 "2c79ffdbc7063e659f5635e54d4ab768557e89371bd02d7d37bcb43b968b7c03" => :el_capitan
    sha256 "c2f40489bd10f0c5c358e0dffee3096a209de8d71ba90121b580391e23afdcb4" => :yosemite
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
