require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Gmagick < AbstractPhp55Extension
  init
  homepage "https://pecl.php.net/package/gmagick"
  url "https://pecl.php.net/get/gmagick-1.1.7RC2.tgz"
  sha256 "8e51c8343d6e6d556d7b17417ce338c6ed2b0893869f1494410dfe6ba5105475"

  bottle do
    sha256 "1419c7b3d6a8ff8d072765eabca6cebcd22f8316602bb6705ce146aa10c61e67" => :el_capitan
    sha256 "e241ff365bc38a158114fa88663d718aac733e3e3ca029defa47c8796ebd44c5" => :yosemite
    sha256 "a81b82591f1877b37019f56fc0e8b42e4a60a9804a18389d85f89ec17caf5e45" => :mavericks
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
