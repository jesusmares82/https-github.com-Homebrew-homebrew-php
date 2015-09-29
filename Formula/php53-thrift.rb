require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Thrift < AbstractPhp53Extension
  init
  homepage "https://thrift.apache.org/"
  url "https://github.com/apache/thrift/archive/0.9.2.tar.gz"
  sha256 "1eacc3d65b910fadf7969326285170d33cbe9fe30cc7bf421916f753edb3dabb"

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
