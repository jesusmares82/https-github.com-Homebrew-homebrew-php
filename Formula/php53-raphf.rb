require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Raphf < AbstractPhp53Extension
  init
  desc "A reusable split-off of pecl_http's persistent handle and resource factory API."
  homepage "https://pecl.php.net/package/raphf"
  url "https://pecl.php.net/get/raphf-1.0.4.tgz"
  sha256 "461be283e89d94186a3ed4651b92c7c1a067bad7b6476d0ca7ac8863dc1ed8bf"

  bottle do
    sha256 "d85407c95983c971a3d739e723379ce76f15e1079ef29dae87154da025451284" => :yosemite
    sha256 "6f5e4fac12bb82faa93896c815ceb14305d64096ef57229ec151eb71b2f019ed" => :mavericks
    sha256 "083d883ccc79f29b185bb4e73f4560f8bde0fc20f0cfa9ad3479779f3db289c4" => :mountain_lion
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
