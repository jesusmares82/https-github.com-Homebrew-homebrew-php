require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pspell < AbstractPhp71Extension
  init
  desc "Extension to check the spelling"
  homepage "https://php.net/manual/en/book.pspell.php"
  revision 17

  bottle do
    sha256 "fb801a046af2ffa3a102b543a82f315f184bb372c4eef0bb6a4f60bd96b533ec" => :high_sierra
    sha256 "b395df30ab842738297676661f7ce66d9b51bc25f16f73f1a8b4aed76739d26f" => :sierra
    sha256 "eeda341e5e8fee0a069ffdcbbd00d67c04eb721407f36a91e11857ce26c8ba95" => :el_capitan
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
