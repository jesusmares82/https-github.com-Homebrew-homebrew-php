require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Redis < AbstractPhp55Extension
  init
  homepage 'https://github.com/nicolasff/phpredis'
  url 'https://github.com/nicolasff/phpredis/archive/2.2.3.tar.gz'
  sha1 '99074be0285cd7b1140a971bf5340ef5cbea142a'
  head 'https://github.com/nicolasff/phpredis.git'

  option 'with-igbinary', "Build with igbinary support"
  depends_on 'php55-igbinary' if build.include?('with-igbinary')

  fails_with :clang do
    build 318
    cause <<-EOS.undent
      argument to 'va_arg' is of incomplete type 'void'
      This is fixed in HEAD, and can be removed for the next release.
      EOS
  end unless build.head?

  def install
    ENV.universal_binary if build.universal?

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig
    args << "--enable-redis-igbinary" if build.include? 'with-igbinary'

    safe_phpize
    system "./configure", *args
    system "make"
    prefix.install "modules/redis.so"
    write_config_file unless build.include? "without-config-file"
  end
end
