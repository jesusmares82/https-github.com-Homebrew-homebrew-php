require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Xdebug < AbstractPhp54Extension
  init
  homepage 'http://xdebug.org'
  url 'http://xdebug.org/files/xdebug-2.2.7.tgz'
  sha1 '587d300b8df0d1213910c59dda0c4f5807233744'
  head 'https://github.com/xdebug/xdebug.git'

  bottle do
    root_url "https://downloads.sf.net/project/machomebrew/Bottles/php"
    sha1 "16d2f4d852b96f100b8cb9c34ad9d1030e347096" => :yosemite
    sha1 "05165b0d517806c790626325b0394e7d198bda21" => :mavericks
    sha1 "069fa69c3e4c9e6fc788b701cb99f5a42cf1908d" => :mountain_lion
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
