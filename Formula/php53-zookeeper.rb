require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Zookeeper < AbstractPhp53Extension
  homepage 'http://pecl.php.net/package/zookeeper'
  url 'http://pecl.php.net/get/zookeeper-0.2.2.tgz'
  sha1 '029c0d9c989c56c5afead8bb4621b7f2236a7b6f'
  head 'https://github.com/andreiz/php-zookeeper.git'

  def self.init
    super
    option 'disable-session', 'Disable zookeeper session handler support'
    depends_on 'zookeeper' => '--c'
  end

  init

  def install
    Dir.chdir "zookeeper-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig
    args << "--with-libzookeeper-dir=#{Formula['zookeeper'].opt_prefix}"
    args << "--disable-zookeeper-session" if build.include? 'disable-session'

    safe_phpize

    system "./configure", *args
    system "make"
    prefix.install "modules/zookeeper.so"
    write_config_file if build.with? "config-file"
  end

  def caveats
    super + <<-EOS.undent

      Note that zookeeper must be installed with the --c option for the
      PHP extension to build.

    EOS
  end

end
