require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Zmq < AbstractPhp55Extension
  init
  homepage 'http://php.zero.mq/'
  url 'https://github.com/mkoppanen/php-zmq/archive/1.1.2.tar.gz'
  sha1 '735d8c826edffcc96aa75b33d9aa13dbe57f2059'
  head 'https://github.com/mkoppanen/php-zmq.git'

  depends_on 'pkg-config' => :build
  depends_on 'zeromq'

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/zmq.so"
    write_config_file if build.with? "config-file"
  end
end
