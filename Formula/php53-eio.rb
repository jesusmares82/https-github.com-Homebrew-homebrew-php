require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Eio < AbstractPhp53Extension
  init
  homepage 'http://pecl.php.net/package/eio'
  url 'http://pecl.php.net/get/eio-1.2.5.tgz'
  sha256 'ee7b21aa413cbe39caaef1d2eb893fa3bcb9a278b5665c28d179a83a4a1bdb51'
  head 'https://bitbucket.org/osmanov/pecl-eio.git'

  bottle do
    cellar :any_skip_relocation
    sha256 "22158537b8e84027c0f4ce2756ce5b863e9ba2f6f4beb036dc3ad711e32ff56a" => :mavericks
  end

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
