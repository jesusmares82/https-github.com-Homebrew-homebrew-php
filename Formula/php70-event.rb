require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Event < AbstractPhp70Extension
  init
  desc "Provides interface to libevent library"
  homepage "https://pecl.php.net/package/event"
  url "https://pecl.php.net/get/event-2.0.0.tgz"
  sha256 "3f785022b60d8e8687825c89a314ef94b1dbbbcb9438c3e5b3b9d840d5119a1b"

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
