require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Zmq < AbstractPhp55Extension
  init
  homepage 'http://php.zero.mq/'
  url 'https://github.com/mkoppanen/php-zmq/archive/1.0.8.tar.gz'
  sha1 '62a1390941540f899dd6ae1826f30a15e082b474'
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
    write_config_file unless build.include? "without-config-file"
  end
end
