require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Vld < AbstractPhp55Extension
  init
  homepage "https://pecl.php.net/package/vld"
  url "https://pecl.php.net/get/vld-0.13.0.tgz"
  sha256 "f61fe6501b6f30cf5628b7fd0e2c41185bb9bfac96b765c8b967a8ba01f7bf8b"
  head "https://github.com/derickr/vld.git"

  def install
    Dir.chdir "vld-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/vld.so"
    write_config_file if build.with? "config-file"
  end
end
