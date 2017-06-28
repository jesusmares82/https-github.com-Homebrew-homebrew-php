require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Event < AbstractPhp72Extension
  init
  desc "Provides interface to libevent library"
  homepage "https://pecl.php.net/package/event"
  url "https://pecl.php.net/get/event-2.2.1.tgz"
  sha256 "44756686df68d8ef4fcee31359c0c03802b1f55ad88db7ac142169777f3d17ef"
  head "https://bitbucket.org/osmanov/pecl-event.git"

  bottle do
    sha256 "11de92c1be6b7c655293d628f9bfbf911d277e794faee4ecbd85b31e67f274be" => :sierra
    sha256 "30dc893400f6d1055d894919c61a4ded59693f762012156ddbac226deec82001" => :el_capitan
    sha256 "1d99173dd984c7687a15677ec928094e1ec86d6e62f56d6ba1f937a4f8d4936b" => :yosemite
  end

  depends_on "libevent"
  depends_on "openssl"

  def install
    Dir.chdir "event-#{version}" unless build.head?

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
