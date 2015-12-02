require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Raphf < AbstractPhp56Extension
  init
  desc "A reusable split-off of pecl_http's persistent handle and resource factory API."
  homepage "https://pecl.php.net/package/raphf"
  url "https://pecl.php.net/get/raphf-1.0.4.tgz"
  sha256 "461be283e89d94186a3ed4651b92c7c1a067bad7b6476d0ca7ac8863dc1ed8bf"

  bottle do
    sha256 "99977faae951ff350b5548de02898e68aa42f4e565cccfffff445491fce8953b" => :yosemite
    sha256 "68ecac431c3ab1a297432256cc296f8b5dfddcd4f96af408f6706428da9d9c1b" => :mavericks
    sha256 "f40e19b76251d553af0919dfe24a8c7e0fd992f7ead642ed05fb466c7dd03971" => :mountain_lion
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
