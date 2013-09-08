require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Xhp < AbstractPhp54Extension
  init
  homepage 'https://github.com/facebook/xhp'
  url 'https://github.com/facebook/xhp/archive/0bdf54f6a333228094d6811a362836d15145eea4.tar.gz'
  sha1 '41f132545fd2605962703073cb1abc36839de608'
  head 'https://github.com/facebook/xhp.git'
  version '0bdf54f'

  depends_on 'pcre'
  depends_on 're2c'

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/xhp.so"

    write_config_file unless build.include? "without-config-file"
  end
end
