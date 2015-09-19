require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Eio < AbstractPhp56Extension
  init
  homepage 'https://pecl.php.net/package/eio'
  url 'https://pecl.php.net/get/eio-1.2.5.tgz'
  sha256 'ee7b21aa413cbe39caaef1d2eb893fa3bcb9a278b5665c28d179a83a4a1bdb51'
  head 'https://bitbucket.org/osmanov/pecl-eio.git'

  depends_on 'libevent' => :build

  def install
    Dir.chdir "eio-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--with-eio"
    args << "--enable-eio-sockets"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/eio.so"
    write_config_file if build.with? "config-file"
  end
end
