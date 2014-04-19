require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Riak < AbstractPhp54Extension
  init
  homepage 'http://phpriak.bachpedersen.dk/'
  url 'http://pecl.php.net/get/riak-1.1.5.tgz'
  sha1 '358eb2ca0015d04e693b50bd386075a88c42e23d'
  head 'https://github.com/TriKaspar/php_riak.git'

  option 'with-riak', 'Also install Riak locally'

  depends_on 'riak' => :optional

  def install
    Dir.chdir "riak-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/riak.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<-EOS.undent
      riak.persistent.connections=20
      riak.persistent.timeout=1800
      riak.socket.keep_alive=1
      riak.socket.recv_timeout=10000
      riak.socket.send_timeout=10000
    EOS
  end

  def caveats
    super + <<-EOS.undent

      Note that this formula will NOT install Riak unless you intall
      it with --with-riak option.

      If you want to ensure Riak is installed:
        brew install riak

    EOS
   end
end
