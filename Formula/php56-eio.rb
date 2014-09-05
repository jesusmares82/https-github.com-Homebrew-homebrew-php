require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Eio < AbstractPhp56Extension
  init
  homepage 'http://pecl.php.net/package/eio'
  url 'http://pecl.php.net/get/eio-1.2.5.tgz'
  sha1 'a362e72fd7c7fb3317761c6c0920c438127fdfbf'
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
