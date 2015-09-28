require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Protobuf < AbstractPhp54Extension
  init
  homepage "https://github.com/allegro/php-protobuf"
  head "https://github.com/allegro/php-protobuf.git"
  url "https://github.com/allegro/php-protobuf/archive/0.10.tar.gz"
  sha256 "442e83dd47f5052e7e0bd4a46ab190a46115781e3c520df8319779689920a411"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/protobuf.so"
    write_config_file if build.with? "config-file"
  end
end
