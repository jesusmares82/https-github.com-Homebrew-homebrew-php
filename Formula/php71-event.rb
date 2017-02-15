require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Event < AbstractPhp71Extension
  init
  desc "Provides interface to libevent library"
  homepage "https://pecl.php.net/package/event"
  url "https://pecl.php.net/get/event-2.2.1.tgz"
  sha256 "44756686df68d8ef4fcee31359c0c03802b1f55ad88db7ac142169777f3d17ef"
  head "https://bitbucket.org/osmanov/pecl-event.git"

  bottle do
    sha256 "433462a8be4065098d3c513fea33a4db08e39e8449b340a9649a637d87343619" => :el_capitan
    sha256 "30da93e0498cdc4063d522e21bc74d387831435d0acbfa3c99e96cbbd61d8716" => :yosemite
    sha256 "4d11a5c8173a0b0a42ada3081ec3183df0850b597bc7884096abb58dd34b352f" => :mavericks
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
