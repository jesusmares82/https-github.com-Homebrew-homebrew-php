require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Inclued < AbstractPhp56Extension
  init
  homepage 'http://pecl.php.net/package/inclued'
  url 'http://pecl.php.net/get/inclued-0.1.3.tgz'
  sha1 '3967cfa654a9bd7f0a793700030c5d28b744d48d'
  head 'https://svn.php.net/repository/pecl/inclued/trunk'

  def install
    Dir.chdir "inclued-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/inclued.so"
    write_config_file if build.with? "config-file"
  end
end
