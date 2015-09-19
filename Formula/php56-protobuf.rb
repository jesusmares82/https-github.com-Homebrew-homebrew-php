require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Protobuf < AbstractPhp56Extension
  init
  homepage 'https://github.com/allegro/php-protobuf'
  head 'https://github.com/allegro/php-protobuf.git'
  url 'https://github.com/allegro/php-protobuf/archive/5839c25f1472736637e8c0484e542135f5636146.tar.gz'
  sha256 'df0ab827f6a522f0a09c6fbde6bae1d9c210ba82af4295f19f43c4ca096c1ca0'
  version '5839c25'

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/protobuf.so"
    write_config_file if build.with? "config-file"
  end
end
