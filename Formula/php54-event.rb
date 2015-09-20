require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Event < AbstractPhp54Extension
  init
  desc "Provides interface to libevent library"
  homepage "https://pecl.php.net/package/event"
  url "https://pecl.php.net/get/event-1.11.1.tgz"
  sha256 "371e8d559461542058efd57be61fd8316121985dc455f2e7979722e37cedd526"
  head "https://bitbucket.org/osmanov/pecl-event.git"

  bottle do
    sha256 "f23e58094a8466d7ca281d5c5412a4d41ddc9b92c782eb036b8568ba51bd8e82" => :el_capitan
    sha256 "08b571408fedc69ae4b1725fe05f4c9f4799b7ec734e8666bd3979f86d1b4b5b" => :yosemite
    sha256 "8517406a6307040ac9f4a1d99b09abba327bb0478d5625b25bf0c24a06da9422" => :mavericks
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
