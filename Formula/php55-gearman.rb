require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Gearman < AbstractPhp55Extension
  init
  homepage 'http://pecl.php.net/package/gearman'
  url 'http://pecl.php.net/get/gearman-1.1.2.tgz'
  sha1 '4b4d92b0dec9aabf8cd1ed6eba1f0cf8414117c9'
  head 'https://svn.php.net/repository/pecl/gearman/trunk/'

  depends_on 'gearman'

  def install
    Dir.chdir "gearman-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-gearman=#{Formula['gearman'].opt_prefix}"
    system "make"
    prefix.install "modules/gearman.so"
    write_config_file if build.with? "config-file"
  end
end
