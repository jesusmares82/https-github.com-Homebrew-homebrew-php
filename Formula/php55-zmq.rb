require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Zmq < AbstractPhp55Extension
  init
  homepage 'http://php.zero.mq/'
  url 'https://github.com/mkoppanen/php-zmq/archive/1.0.5.tar.gz'
  sha1 '9be2a968985d1af87bc8549a5c0944fba9a80e6d'
  head 'https://github.com/mkoppanen/php-zmq.git'

  depends_on 'pkg-config'

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
