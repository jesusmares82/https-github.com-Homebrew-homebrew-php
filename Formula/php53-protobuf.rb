require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Protobuf < AbstractPhp53Extension
  init
  homepage "https://github.com/allegro/php-protobuf"
  head "https://github.com/allegro/php-protobuf.git"
  url "https://github.com/allegro/php-protobuf/archive/0.10.tar.gz"
  sha256 "442e83dd47f5052e7e0bd4a46ab190a46115781e3c520df8319779689920a411"

  bottle do
    cellar :any_skip_relocation
    sha256 "14b87dc0012d0ae5b9a7483e0eff2cb515901578ed2f9b0d828c85cbec72a579" => :el_capitan
    sha256 "6f5afd80c0eef7d3d222ca0d5ca328448fdc6a06fc3aaeb2f909e485821db0d4" => :yosemite
    sha256 "2dae3a56f824c1824a63516d1352a0ef766b9ec8ca01d4715506293977496290" => :mavericks
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/protobuf.so"
    write_config_file if build.with? "config-file"
  end
end
