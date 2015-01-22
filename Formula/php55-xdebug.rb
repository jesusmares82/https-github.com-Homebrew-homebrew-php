require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Xdebug < AbstractPhp55Extension
  init
  homepage 'http://xdebug.org'
  url 'http://xdebug.org/files/xdebug-2.2.7.tgz'
  sha1 '587d300b8df0d1213910c59dda0c4f5807233744'
  head 'https://github.com/xdebug/xdebug.git'

  bottle do
    root_url "https://downloads.sf.net/project/machomebrew/Bottles/php"
    sha1 "93fb4659e78d4c98150dbc6241aed7ffed4aab34" => :yosemite
    sha1 "52b3bca92610cf9b346affed7806311c9a6e1750" => :mavericks
    sha1 "f54f0f3da1734dee520759c20c55070a8f482a48" => :mountain_lion
  end

  def extension_type; "zend_extension"; end

  def install
    Dir.chdir "xdebug-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--enable-xdebug"
    system "make"
    prefix.install "modules/xdebug.so"
    write_config_file if build.with? "config-file"
  end
end
