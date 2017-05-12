require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pspell < AbstractPhp71Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  revision 12

  bottle do
    sha256 "62f5b2079ec953eb85a37bf0b67646d475944b739764ae036df1574328c8b014" => :sierra
    sha256 "965ce1b24b9d5cd5047ea44744e3d63ad856eae854c5637020177388a30f37bd" => :el_capitan
    sha256 "cd1e520e0400c636b15362f1cee4160ba165c0eff7a482192fb40cdee991b96c" => :yosemite
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
