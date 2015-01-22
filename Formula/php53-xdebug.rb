require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Xdebug < AbstractPhp53Extension
  init
  homepage 'http://xdebug.org'
  url 'http://xdebug.org/files/xdebug-2.2.7.tgz'
  sha1 '587d300b8df0d1213910c59dda0c4f5807233744'
  head 'https://github.com/xdebug/xdebug.git'

  bottle do
    root_url "https://downloads.sf.net/project/machomebrew/Bottles/php"
    sha1 "59ba78e1e261ba41d4d7ba99857204a943e38da7" => :yosemite
    sha1 "62fc3b788da8e383929f8df4816c4a438c5edc98" => :mavericks
    sha1 "7cb5e6c1f6e50a1bf41ab0a295caad9b3520e61f" => :mountain_lion
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
