require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Ev < AbstractPhp55Extension
  init
  homepage 'http://pecl.php.net/package/ev'
  url 'http://pecl.php.net/get/ev-0.2.3.tgz'
  sha1 '9b818ac6f23994f8b53cc164f65bf649d4562c9c'
  head 'https://bitbucket.org/osmanov/pecl-ev.git'

  depends_on 'libev'

  def install
    Dir.chdir "ev-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-libev=#{Formula.factory('libev').opt_prefix}"
    system "make"
    prefix.install "modules/ev.so"
    write_config_file unless build.include? "without-config-file"
  end
end
