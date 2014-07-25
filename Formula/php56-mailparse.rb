require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mailparse < AbstractPhp56Extension
  init
  homepage 'http://pecl.php.net/package/mailparse'
  url 'http://pecl.php.net/get/mailparse-2.1.6.tgz'
  sha1 'f0deaa433a1f7833e80f80dabc1bbbdbe0071b3c'
  head 'https://svn.php.net/repository/pecl/mailparse/trunk'

  depends_on 'pcre'

  def install
    Dir.chdir "mailparse-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/mailparse.so"
    write_config_file if build.with? "config-file"
  end
end
