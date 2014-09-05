require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Riak < AbstractPhp56Extension
  init
  homepage 'http://phpriak.bachpedersen.dk/'
  url 'http://pecl.php.net/get/riak-1.2.0.tgz'
  sha1 'c48afd6482df5bd3520505edead26104e65955d1'
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
