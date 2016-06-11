require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Raphf < AbstractPhp56Extension
  init
  desc "Split-off of pecl_http's persistent handle and resource factory API"
  homepage "https://pecl.php.net/package/raphf"
  url "https://github.com/m6w6/ext-raphf/archive/release-1.1.2.tar.gz"
  sha256 "b5386eff888e2c06951b4fa65a3d0b536775e35a8afc2db323a3129685f7c2bf"

  bottle do
    sha256 "99977faae951ff350b5548de02898e68aa42f4e565cccfffff445491fce8953b" => :yosemite
    sha256 "68ecac431c3ab1a297432256cc296f8b5dfddcd4f96af408f6706428da9d9c1b" => :mavericks
    sha256 "f40e19b76251d553af0919dfe24a8c7e0fd992f7ead642ed05fb466c7dd03971" => :mountain_lion
  end

  def install
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
