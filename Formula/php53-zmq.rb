require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Zmq < AbstractPhp53Extension
  init
  homepage 'http://php.zero.mq/'
  url 'https://github.com/mkoppanen/php-zmq/archive/1.0.6.tar.gz'
  sha1 '7754db7e69d881aa76c8493f35e84513f1b465f0'
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
