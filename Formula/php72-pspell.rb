require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Pspell < AbstractPhp72Extension
  init
  desc "Extension to check the spelling"
  homepage "https://php.net/manual/en/book.pspell.php"
  revision 10

  bottle do
    sha256 "a78d918bb425729eee2c5a4cf0fda29360f7f530cba7f56707e42ce9f61a8241" => :high_sierra
    sha256 "a2c182bc21be0f863ea8799bbdfb8c60b2d965e7bcf51fc6eb3cf91f3c47494e" => :sierra
    sha256 "6309597eaf7e72baa1741a24247eb87f9ed51aba46fc9b38a9578f29f7d24ba5" => :el_capitan
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
