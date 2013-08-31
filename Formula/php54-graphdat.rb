require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Graphdat < AbstractPhp54Extension
  init
  homepage 'http://www.graphdat.com/'
  url 'http://pecl.php.net/get/graphdat-1.0.1.tgz'
  sha1 '7f3d691d3700e363d29437432a0a97099e4b7600'
  head 'https://github.com/alphashack/graphdat-sdk-php.git'

  def install
    Dir.chdir "graphdat-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/graphdat.so"
    write_config_file unless build.include? "without-config-file"
  end
end
