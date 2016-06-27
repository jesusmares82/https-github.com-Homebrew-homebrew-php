require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Raphf < AbstractPhp54Extension
  init
  desc "Split-off of pecl_http's persistent handle and resource factory API"
  homepage "https://pecl.php.net/package/raphf"
  url "https://github.com/m6w6/ext-raphf/archive/release-1.1.2.tar.gz"
  sha256 "b5386eff888e2c06951b4fa65a3d0b536775e35a8afc2db323a3129685f7c2bf"

  bottle do
    sha256 "0444c011ea0056323df3c937696c83cea2a6389ebde81d8e63722f6ce16c973f" => :yosemite
    sha256 "6c206ad96c13cd3fddbd2beb093610bf0db4748f3cbce306cc58625cb5603430" => :mavericks
    sha256 "758168de0b7c719a32dd8056a54f6cf948ebab50fd228b5ad6fa9ec241e59ba7" => :mountain_lion
  end

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
