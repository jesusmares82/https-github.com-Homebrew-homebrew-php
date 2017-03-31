require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Raphf < AbstractPhp70Extension
  init
  desc "Split-off of pecl_http's persistent handle and resource factory API"
  homepage "https://pecl.php.net/package/raphf"
  url "https://github.com/m6w6/ext-raphf/archive/release-2.0.0.tar.gz"
  sha256 "eb4356e13769bf76efc27bce4ad54f508701bcdac3c255dd1c8eb1e87fccb9fa"
  head "https://github.com/m6w6/ext-raphf.git"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    include.install %w[php_raphf.h src/php_raphf_api.h]
    prefix.install "modules/raphf.so"
    write_config_file if build.with? "config-file"
  end
end
