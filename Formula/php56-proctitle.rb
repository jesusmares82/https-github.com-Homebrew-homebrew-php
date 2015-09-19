require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Proctitle < AbstractPhp56Extension
  init
  homepage 'https://pecl.php.net/package/proctitle'
  url 'https://pecl.php.net/get/proctitle-0.1.2.tgz'
  sha256 'b9f84b1aebbee31cee627356438def1321d1f3bcd480341501315f35f0f9e272'
  head 'https://github.com/MagicalTux/proctitle.git'

  def install
    Dir.chdir "proctitle-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w(modules/proctitle.so)
    write_config_file if build.with? "config-file"
  end
end
