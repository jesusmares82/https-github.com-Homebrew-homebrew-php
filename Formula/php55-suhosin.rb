require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Suhosin < AbstractPhp55Extension
  init
  homepage 'http://suhosin.org/stories/index.html'
  url 'https://github.com/stefanesser/suhosin/archive/suhosin-0.9.36.tar.gz'
  sha1 '66801a40dc892542276320e30716aa2590912ae6'
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
