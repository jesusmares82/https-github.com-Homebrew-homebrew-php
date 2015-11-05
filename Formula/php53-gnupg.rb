require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Gnupg < AbstractPhp53Extension
  init
  desc "Wrapper around the gpgme library"
  homepage "https://pecl.php.net/package/gnupg"
  url "https://pecl.php.net/get/gnupg-1.3.6.tgz"
  sha256 "50065cb81f1ac3ec5fcd796e58c8433071ff24cc14900e6077682717f5239307"

  depends_on "gpgme"

  def install
    Dir.chdir "gnupg-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/gnupg.so"
    write_config_file if build.with? "config-file"
  end
end
