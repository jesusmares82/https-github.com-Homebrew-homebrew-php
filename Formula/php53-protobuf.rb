require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Protobuf < AbstractPhp53Extension
  init
  homepage 'https://github.com/allegro/php-protobuf'
  head 'https://github.com/allegro/php-protobuf.git'
  url 'https://github.com/allegro/php-protobuf/archive/0.10.tar.gz'
  sha1 'a8553d4090f4da4882a16f51c50319eba5704be2'

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/protobuf.so"
    write_config_file if build.with? "config-file"
  end
end
