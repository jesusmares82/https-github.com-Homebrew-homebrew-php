require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Redis < AbstractPhp54Extension
  init
  homepage 'https://github.com/nicolasff/phpredis'
  url 'https://github.com/nicolasff/phpredis/tarball/2.2.3'
  sha1 '84480a8c494f14eee7bb295e5a6dbdb9185f487b'
  head 'https://github.com/nicolasff/phpredis.git'

  option 'with-igbinary', "Build with igbinary support"
  depends_on 'php54-igbinary' if build.include?('with-igbinary')

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
