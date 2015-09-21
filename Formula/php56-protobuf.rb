require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Protobuf < AbstractPhp56Extension
  init
  homepage "https://github.com/allegro/php-protobuf"
  head "https://github.com/allegro/php-protobuf.git"
  url "https://github.com/allegro/php-protobuf/archive/5839c25f1472736637e8c0484e542135f5636146.tar.gz"
  sha256 "df0ab827f6a522f0a09c6fbde6bae1d9c210ba82af4295f19f43c4ca096c1ca0"
  version "5839c25"

  bottle do
    cellar :any_skip_relocation
    sha256 "b51ba28aae7aecbc949d54b49ecaa45dd5379eba49d3bf7cc9a9f5787ee95a54" => :el_capitan
    sha256 "af33bf20a42a15b83392dbab3f9f7732736ddc92ba9a7e71f07c5d8e2e8f208b" => :yosemite
    sha256 "446c7edc10781e577e1d4f37873938b77227a7be333d6309b35828c4e68ed2de" => :mavericks
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/protobuf.so"
    write_config_file if build.with? "config-file"
  end
end
