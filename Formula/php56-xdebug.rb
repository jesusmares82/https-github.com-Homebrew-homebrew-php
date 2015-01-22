require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Xdebug < AbstractPhp56Extension
  init
  homepage 'http://xdebug.org'
  url 'http://xdebug.org/files/xdebug-2.2.7.tgz'
  sha1 '587d300b8df0d1213910c59dda0c4f5807233744'
  head 'https://github.com/xdebug/xdebug.git'

  bottle do
    root_url "https://downloads.sf.net/project/machomebrew/Bottles/php"
    sha1 "24cda414a46d31cfe04dffb689053e126768e187" => :yosemite
    sha1 "67efc6a1aaa03bcd831e9362b14e5d8da981d30e" => :mavericks
    sha1 "ea59ab9694bf12f5c98b87b0ee4a4b436b9626ba" => :mountain_lion
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
