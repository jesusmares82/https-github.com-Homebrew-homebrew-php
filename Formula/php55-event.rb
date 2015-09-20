require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Event < AbstractPhp55Extension
  init
  desc "Provides interface to libevent library"
  homepage "https://pecl.php.net/package/event"
  url "https://pecl.php.net/get/event-1.11.1.tgz"
  sha256 "371e8d559461542058efd57be61fd8316121985dc455f2e7979722e37cedd526"
  head "https://bitbucket.org/osmanov/pecl-event.git"

  bottle do
    sha256 "0be96d5978f723aea50c8f23ee4b865a039b5b01ec1680dd7bd7f1227e5b4da6" => :el_capitan
    sha256 "bdbb518182fa7b201a5092b559e6e3b4e0539a859587099d2a8eeda25da00455" => :yosemite
    sha256 "30674dfe8d65a7147bbebd8c70b73c4cd1310faf5f4f4e9d0c3d2f9204b51787" => :mavericks
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
