require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Pspell < AbstractPhp72Extension
  init
  desc "Extension to check the spelling"
  homepage "https://php.net/manual/en/book.pspell.php"
  revision 5

  bottle do
    sha256 "e86e8ae29cc3ee1125473ba84648636c499aab25f46d304d550301c748e8e9de" => :high_sierra
    sha256 "1edf853ab534d751fc0ca41e4540ca71435bb6970eaf08c683cd0e5e5dfe0949" => :sierra
    sha256 "c0d77a9ff68bfe1d5ac051110feb2740b5a4fa8ce955c53eff07c2edec8186ba" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

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
