require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pspell < AbstractPhp70Extension
  init
  desc "Extension to check the spelling"
  homepage "http://php.net/manual/en/book.pspell.php"
  bottle do
    sha256 "a99a6f9a358641bdde9fe058273792d90b5423cc21f59139389717e52c30e39a" => :yosemite
    sha256 "1b3b6249b24d18a4f38380c3925b20ddd786de24209511a6c2c44f75c19df297" => :mavericks
    sha256 "4751e2adc9bb818891a4398b742e57385d54d2c8709b4e9293e73c65e5b4430f" => :mountain_lion
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

  test do
    shell_output("php -m").include?("pspell")
  end
end

