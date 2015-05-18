require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Suhosin < AbstractPhp56Extension
  init
  homepage 'http://suhosin.org/stories/index.html'
  url 'https://github.com/stefanesser/suhosin/archive/0.9.37.1.tar.gz'
  sha256 '322ba104a17196bae63d39404da103fd011b09fde0f02484dc44366511c586ba'
  head 'https://github.com/stefanesser/suhosin.git'

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/suhosin.so"
    write_config_file if build.with? "config-file"
  end
end
