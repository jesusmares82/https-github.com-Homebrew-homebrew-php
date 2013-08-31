require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Raphf < AbstractPhp54Extension
  init
  homepage 'http://pecl.php.net/package/raphf'
  url 'http://pecl.php.net/get/raphf-1.0.2.tgz'
  sha1 '5780a4a141119d4a5b63d22ee9a986801b437bf0'

  def install
    Dir.chdir "raphf-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/raphf.so"
    write_config_file unless build.include? "without-config-file"
  end
end
