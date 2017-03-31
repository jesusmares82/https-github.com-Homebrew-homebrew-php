require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Propro < AbstractPhp70Extension
  init
  desc "Reusable split-off of pecl_http's property proxy API."
  homepage "https://pecl.php.net/package/propro"
  url "https://github.com/m6w6/ext-propro/archive/release-2.0.1.tar.gz"
  sha256 "0f310cf0ea11950ff48073537b87b99826ad653c8405556fa42475504c263b64"
  head "https://github.com/m6w6/ext-propro.git"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    include.install %w[php_propro.h src/php_propro_api.h]
    prefix.install "modules/propro.so"
    write_config_file if build.with? "config-file"
  end
end
