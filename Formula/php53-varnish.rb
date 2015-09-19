require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Varnish < AbstractPhp53Extension
  init
  desc "Varnish Cache bindings"
  homepage "https://pecl.php.net/package/varnish"
  url "https://pecl.php.net/get/varnish-1.2.1.tgz"
  sha256 "13d2a4b63197d66854850c5aef50353d87ce3ed95798ba179fb59e289030183a"

  depends_on "varnish"

  def install
    Dir.chdir "varnish-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize

    args = []
    args << "--with-varnish=#{Formula["varnish"].opt_prefix}"
    args << "--prefix=#{prefix}"
    args << phpconfig

    system "./configure", *args
    system "make"
    prefix.install "modules/varnish.so"
    write_config_file if build.with? "config-file"
  end
end
