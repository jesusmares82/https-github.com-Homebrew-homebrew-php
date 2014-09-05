require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Boxwood < AbstractPhp56Extension
  init
  homepage 'https://github.com/ning/boxwood'
  url 'https://github.com/ning/boxwood/archive/888ba12635d7c50cb1bbf1cbef513b0ef9238af3.tar.gz'
  sha1 'ee9c9ee53b5a4df29f5b805231f8f624f4705f51'
  version '888ba12'

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig

    system "make"
    prefix.install "modules/boxwood.so"
    write_config_file if build.with? "config-file"
  end
end
