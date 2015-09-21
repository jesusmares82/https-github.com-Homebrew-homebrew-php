require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Thrift < AbstractPhp55Extension
  init
  homepage "http://thrift.apache.org/"
  url "https://github.com/apache/thrift/archive/0.9.2.tar.gz"
  sha1 "d775d8274635ccc0fc83804d53ed7c14f8608e23"

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
    write_config_file if build.with? "config-file"
  end
end
