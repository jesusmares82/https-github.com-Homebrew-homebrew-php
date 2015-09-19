require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Event < AbstractPhp54Extension
  init
  desc "Provides interface to libevent library"
  homepage "https://pecl.php.net/package/event"
  url "https://pecl.php.net/get/event-1.11.1.tgz"
  sha256 "371e8d559461542058efd57be61fd8316121985dc455f2e7979722e37cedd526"
  head "https://bitbucket.org/osmanov/pecl-event.git"

  bottle do
  end

  depends_on "libevent"
  depends_on "openssl"

  def install
    Dir.chdir "event-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--with-event"
    args << "--with-event-extra"
    args << "--with-event-libevent-dir=#{Formula["libevent"].opt_prefix}"
    args << "--with-event-openssl"
    args << "--with-openssl-dir=#{Formula["openssl"].opt_prefix}"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/event.so"
    write_config_file if build.with? "config-file"
  end
end
