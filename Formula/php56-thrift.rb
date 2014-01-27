require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php56Thrift < AbstractPhp56Extension
  init
  homepage 'http://thrift.apache.org/'
  url 'https://github.com/apache/thrift/archive/thrift-0.9.0.tar.gz'
  sha1 'b30577fb631efe74333114a339a8b62014fe5eec'

  def module_path
    prefix / "thrift_protocol.so"
  end

  def install
    Dir.chdir "lib/php/src/ext/thrift_protocol"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/thrift_protocol.so"
    write_config_file unless build.include? "without-config-file"
  end
end
