require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Sundown < AbstractPhp54Extension
  init
  homepage 'http://pecl.php.net/package/sundown'
  url 'http://pecl.php.net/get/sundown-0.3.9.tgz'
  sha1 '27a5f0215e73b9270acc4c27bcfde187b68ea6d4'

  def install
    Dir.chdir "sundown-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/sundown.so"
    write_config_file unless build.include? "without-config-file"
  end
end
