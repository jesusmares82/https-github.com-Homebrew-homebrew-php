require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Protobuf < AbstractPhp54Extension
  init
  homepage 'https://github.com/allegro/php-protobuf'
  head 'https://github.com/allegro/php-protobuf.git'
  url 'https://github.com/allegro/php-protobuf/archive/5839c25f1472736637e8c0484e542135f5636146.zip'
  sha1 'f99207901fa79c157009e7f9498f119115fc9dfe'
  version '5839c25'

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/protobuf.so"
    write_config_file unless build.include? "without-config-file"
  end
end
