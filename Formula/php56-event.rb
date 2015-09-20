require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Event < AbstractPhp56Extension
  init
  desc "Provides interface to libevent library"
  homepage "https://pecl.php.net/package/event"
  url "https://pecl.php.net/get/event-1.11.1.tgz"
  sha256 "371e8d559461542058efd57be61fd8316121985dc455f2e7979722e37cedd526"
  head "https://bitbucket.org/osmanov/pecl-event.git"

  bottle do
    sha256 "75d366b27aa36124862f764bb58327bcafacfcf7ed28857b567f16ee180a0936" => :el_capitan
    sha256 "d4a3762b030c4e83c42cf0370321d548769285dc4ee229593c6eda7f45b3ff5c" => :yosemite
    sha256 "0a49e71277c1cff10edff17af5449927079f25c41b48ee3b60470e54a854845a" => :mavericks
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
