require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Yp < AbstractPhp53Extension
  init
  homepage "https://pecl.php.net/package/yp"
  url "https://pecl.php.net/get/yp-1.0.1.tgz"
  sha256 "097fc6953c8faaf748acb34bb0c11ca81672f46fc19cd48f8a6c7da6714fa468"
  head "https://git.php.net:/repository/pecl/networking/yp.git"

  def install
    Dir.chdir "yp-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/yp.so"
    write_config_file if build.with? "config-file"
  end
end
