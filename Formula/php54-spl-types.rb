require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54SplTypes < AbstractPhp54Extension
  init
  homepage "https://pecl.php.net/package/SPL_Types"
  url "https://pecl.php.net/get/SPL_Types-0.4.0.tgz"
  sha256 "b44101401b2664822fd17e6f491d912203496108ff9d0b86b043bff67c5f724f"

  def install
    Dir.chdir "SPL_Types-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/spl_types.so"
    write_config_file if build.with? "config-file"
  end

  def extension
    "spl_types"
  end
end
