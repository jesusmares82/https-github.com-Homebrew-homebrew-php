require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pspell < AbstractPhp56Extension
  init
  homepage "http://php.net/manual/en/book.pspell.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 3
    sha256 "0f57e3cca4847e451c18dc8328fbd1510c3186982f2fba61a4e0f46fb38dd278" => :el_capitan
    sha256 "8c577e18c321bffba0adbae71f04729f40a2186f41ae2e2023782f7bc306f25f" => :yosemite
    sha256 "426edb2a44ac5a71306cd33ba0fd6011435ace1b5240e5e41f681598db269158" => :mavericks
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
