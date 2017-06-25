require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Raphf < AbstractPhp72Extension
  init
  desc "Split-off of pecl_http's persistent handle and resource factory API"
  homepage "https://pecl.php.net/package/raphf"
  url "https://github.com/m6w6/ext-raphf/archive/release-2.0.0.tar.gz"
  sha256 "eb4356e13769bf76efc27bce4ad54f508701bcdac3c255dd1c8eb1e87fccb9fa"
  head "https://github.com/m6w6/ext-raphf.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "6c80a7a8049c3de3b9c9eec5aa4d2809c9afce2657480e5ae71941373c5112aa" => :sierra
    sha256 "a6bc6e1dbd115ca18d497e9dd75316fabe87a3e7bf614da69e1771433ebbba7d" => :el_capitan
    sha256 "7ebcb86f8c4e4af7ef388399ff9902cff3e10f16bc51bcf969780f115c364bf3" => :yosemite
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    include.install %w[php_raphf.h src/php_raphf_api.h]
    prefix.install "modules/raphf.so"
    write_config_file if build.with? "config-file"
  end
end
