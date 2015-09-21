require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Lz4 < AbstractPhp55Extension
  init
  homepage "https://code.google.com/p/lz4/"
  url "https://github.com/kjdev/php-ext-lz4/archive/0.2.2.tar.gz"
  sha256 "9e37b1ca39013dacd392e31a0f037f9adf2b6f710a733166b0d0168f23f99c3a"

  bottle do
    sha256 "18021610987e22568c296c314bc2c36ac1e9b4bb4d7040071af0a868b7420609" => :yosemite
    sha256 "8d7aea22f9f90221f8b305be1e2eecade83ca33cb5ab6b2fbc5e9f3428b7e5bb" => :mavericks
    sha256 "425d690354de4a4cfdec279c31580a4415ce706981a648466c8a6366bb6c4174" => :mountain_lion
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/lz4.so"
    write_config_file if build.with? "config-file"
  end
end
