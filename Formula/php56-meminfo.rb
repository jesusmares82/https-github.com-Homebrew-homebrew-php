require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Meminfo < AbstractPhp56Extension
  init
  desc "PHP extension to get insight about memory usage"
  homepage "https://github.com/BitOne/php-meminfo"
  url "https://github.com/BitOne/php-meminfo.git",
    :tag => "v0.3.0",
    :revision => "a9e0eefe0b9c88abd7215f688ec0b04d0d20f386"
  head "https://github.com/BitOne/php-meminfo.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "bd45347175ba1d3569373415a641f1a47d6fdb3f325dd8777d316925f32508c4" => :el_capitan
    sha256 "b3d03e2b345879197d03fc27c96ef4f1e9597b5e0d474416fcabdaae4fa11b85" => :yosemite
    sha256 "71b6f58b88f8554f595c330d076aad3e60ebb3bf912817be4b6990e424d1716b" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w[modules/meminfo.so]
    write_config_file if build.with? "config-file"
  end
end
