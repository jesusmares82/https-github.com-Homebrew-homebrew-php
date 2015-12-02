require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Raphf < AbstractPhp54Extension
  init
  desc "A reusable split-off of pecl_http's persistent handle and resource factory API."
  homepage "https://pecl.php.net/package/raphf"
  url "https://pecl.php.net/get/raphf-1.0.4.tgz"
  sha256 "461be283e89d94186a3ed4651b92c7c1a067bad7b6476d0ca7ac8863dc1ed8bf"

  bottle do
    sha256 "0444c011ea0056323df3c937696c83cea2a6389ebde81d8e63722f6ce16c973f" => :yosemite
    sha256 "6c206ad96c13cd3fddbd2beb093610bf0db4748f3cbce306cc58625cb5603430" => :mavericks
    sha256 "758168de0b7c719a32dd8056a54f6cf948ebab50fd228b5ad6fa9ec241e59ba7" => :mountain_lion
  end

  def install
    Dir.chdir "raphf-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    include.install "php_raphf.h"
    prefix.install "modules/raphf.so"
    write_config_file if build.with? "config-file"
  end
end
