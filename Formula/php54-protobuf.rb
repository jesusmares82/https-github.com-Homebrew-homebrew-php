require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Protobuf < AbstractPhp54Extension
  init
  homepage "https://github.com/allegro/php-protobuf"
  head "https://github.com/allegro/php-protobuf.git"
  url "https://github.com/allegro/php-protobuf/archive/0.10.tar.gz"
  sha256 "442e83dd47f5052e7e0bd4a46ab190a46115781e3c520df8319779689920a411"

  bottle do
    cellar :any_skip_relocation
    sha256 "510e3e836a19bf1d558ace694c6078a06f0f6f4840283c0228c1069ae15e3ae3" => :el_capitan
    sha256 "a2a9a9ca0f9a49c9dac25acc91d55eeacaf90d90abc11f1bbed05594afc1fe6a" => :yosemite
    sha256 "1be2f4972441e0506bc5c429dc91f3c5cb412e567964e6c42f0830ca07d034d6" => :mavericks
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/protobuf.so"
    write_config_file if build.with? "config-file"
  end
end
