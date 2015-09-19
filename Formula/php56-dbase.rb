require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Dbase < AbstractPhp56Extension
  init
  homepage 'https://pecl.php.net/package/dbase/5.1.0'
  url 'https://pecl.php.net/get/dbase-5.1.0.tgz'
  sha256 '20d6a40fb2efe4a06f503ec53512d02d71ceda87eac1f55208d7b5398f287a97'
  head 'https://svn.php.net/repository/pecl/dbase/trunk/'

  def install
    Dir.chdir "dbase-5.1.0"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}"

    system "make"
    prefix.install "modules/dbase.so"
    write_config_file if build.with? "config-file"
  end
end
