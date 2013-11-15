require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Raphf < AbstractPhp53Extension
  init
  homepage 'http://pecl.php.net/package/raphf'
  url 'http://pecl.php.net/get/raphf-1.0.3.tgz'
  sha1 'e08d5194dcfe94612677bcaa34c509e3f7475446'

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
