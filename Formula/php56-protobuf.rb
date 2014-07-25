require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Protobuf < AbstractPhp56Extension
  init
  homepage 'https://github.com/allegro/php-protobuf'
  head 'https://github.com/allegro/php-protobuf.git'
  url 'https://github.com/allegro/php-protobuf/archive/5839c25f1472736637e8c0484e542135f5636146.tar.gz'
  sha1 'dd3285c539391334b8d9fa7cc28d580aac6bf242'
  version '5839c25'

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/protobuf.so"
    write_config_file if build.with? "config-file"
  end
end
