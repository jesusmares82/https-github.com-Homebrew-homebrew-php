require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Gmagick < AbstractPhp54Extension
  init
  homepage "https://pecl.php.net/package/gmagick"
  url "https://pecl.php.net/get/gmagick-1.1.7RC2.tgz"
  sha256 "8e51c8343d6e6d556d7b17417ce338c6ed2b0893869f1494410dfe6ba5105475"

  bottle do
    sha256 "e743fd3c5d40900886e4b4ea62499a4f58ba1125db6c046194925f9ac4107048" => :el_capitan
    sha256 "a0784e135f656bf94d0536665ce288a64caeecbc6e19b54e45abcf2d7871143b" => :yosemite
    sha256 "6f0ba802aeb80c200b45f1d8487e206a46da5e5c18665cd9a6e16dcfa2bbdef6" => :mavericks
  end

  depends_on "graphicsmagick"

  def install
    Dir.chdir "gmagick-#{version}"

    ENV.universal_binary if build.universal?

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig
    args << "--with-gmagick=#{Formula["graphicsmagick"].opt_prefix}"

    safe_phpize
    system "./configure", *args

    system "make"
    prefix.install "modules/gmagick.so"
    write_config_file if build.with? "config-file"
  end
end
