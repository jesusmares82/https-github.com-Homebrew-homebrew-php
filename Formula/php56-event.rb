require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Event < AbstractPhp56Extension
  init
  homepage 'http://pecl.php.net/package/event'
  url 'http://pecl.php.net/get/event-1.10.3.tgz'
  sha1 '0d8881b0b157493d399fed9211bc242f1b416245'
  head 'https://bitbucket.org/osmanov/pecl-event.git'

  depends_on 'libevent' => :build

  def install
    Dir.chdir "event-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--with-event"
    args << "--with-event-libevent-dir=#{Formula['libevent'].opt_prefix}"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/event.so"
    write_config_file if build.with? "config-file"
  end
end
