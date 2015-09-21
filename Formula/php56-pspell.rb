require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pspell < AbstractPhp56Extension
  init
  homepage "http://php.net/manual/en/book.pspell.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 1
    sha256 "c19a4092054ad2dd589bb29fbf92616f200690f1f0394b6a362a9e1fd515d07c" => :yosemite
    sha256 "0c2aee56d35fc3ae2e8ce90e43009a722e89242d9e1add2ea59203a5471d3363" => :mavericks
    sha256 "fe8d0662662924721e60bfe738279d43b6ef6d159d1679543627babfef34909c" => :mountain_lion
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
