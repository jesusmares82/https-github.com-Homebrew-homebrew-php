require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Event < AbstractPhp70Extension
  init
  desc "Provides interface to libevent library"
  homepage "https://pecl.php.net/package/event"
  url "https://pecl.php.net/get/event-2.2.1.tgz"
  sha256 "44756686df68d8ef4fcee31359c0c03802b1f55ad88db7ac142169777f3d17ef"
  head "https://bitbucket.org/osmanov/pecl-event.git"

  bottle do
    sha256 "35ea012c45378097d492d2d50e48411c5e59f1a168fd3abe1dfad9a8aeb5968b" => :el_capitan
    sha256 "96fbf07366548b69a06cf2fccb648a180092b635ddbebf385f00907e1045fe99" => :yosemite
    sha256 "4e1c561edacdda0c2f72da047e02c8bf397a4ce1cbca61e727d63a42e75d076d" => :mavericks
  end

  depends_on "libevent"
  depends_on "openssl"

  def install
    Dir.chdir "event-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--with-event-core"
    args << "--with-event-extra"
    args << "--enable-event-debug"
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
