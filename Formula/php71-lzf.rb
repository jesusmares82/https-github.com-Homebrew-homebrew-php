require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Lzf < AbstractPhp71Extension
  init
  desc "handles LZF de/compression"
  homepage "https://pecl.php.net/package/lzf"
  url "https://pecl.php.net/get/LZF-1.6.5.tgz"
  sha256 "dd116d12a3be985f42256650ce9a033fd3c4e8da4f2280c79fb9fd6a73199a4c"
  head "https://github.com/php/pecl-file_formats-lzf.git"

  bottle do
  end

  def install
    Dir.chdir "LZF-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/lzf.so"
    write_config_file if build.with? "config-file"
  end
end
