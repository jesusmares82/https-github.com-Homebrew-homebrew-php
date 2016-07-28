require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Ev < AbstractPhp71Extension
  init
  desc "interface to libev library"
  homepage "https://pecl.php.net/package/ev"
  url "https://pecl.php.net/get/ev-1.0.0.tgz"
  sha256 "f04ea2ccf31ad8f0736586e31cc003401828b598242f4a45fddd8abd2c931e87"
  head "https://bitbucket.org/osmanov/pecl-ev.git"

  bottle do
  end

  depends_on "libev"

  def install
    Dir.chdir "ev-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-libev=#{Formula["libev"].opt_prefix}"
    system "make"
    prefix.install "modules/ev.so"
    write_config_file if build.with? "config-file"
  end
end
