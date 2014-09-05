require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Xhp < AbstractPhp56Extension
  init
  homepage 'https://github.com/facebook/xhp'
  url 'https://github.com/facebook/xhp/archive/0bdf54f6a333228094d6811a362836d15145eea4.tar.gz'
  sha1 '41f132545fd2605962703073cb1abc36839de608'
  head 'https://github.com/facebook/xhp.git'
  version '0bdf54f'

  depends_on 'pcre'
  depends_on 're2c'

  fails_with :clang do
    cause <<-EOS.undent
      Clang which does not support the standard rope implementation. Use gcc instead.
      Source: https://github.com/facebook/xhp/commit/8aa2d9fa6bf3a114e113ba5c554181279545fb2f
    EOS
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/xhp.so"

    write_config_file if build.with? "config-file"
  end
end
