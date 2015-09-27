require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Zookeeper < AbstractPhp55Extension
  init
  homepage "https://pecl.php.net/package/zookeeper"
  url "https://pecl.php.net/get/zookeeper-0.2.2.tgz"
  sha256 "ce657910472b0880e2f9dd0c73558a94a15c2cfc0208ba305dcc02e27cb34f78"
  head "https://github.com/andreiz/php-zookeeper.git"

  option "disable-session", "Disable zookeeper session handler support"
  depends_on "zookeeper"

  def install
    Dir.chdir "zookeeper-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig
    args << "--with-libzookeeper-dir=#{Formula["zookeeper"].opt_prefix}"
    args << "--disable-zookeeper-session" if build.include? "disable-session"

    safe_phpize

    system "./configure", *args
    system "make"
    prefix.install "modules/zookeeper.so"
    write_config_file if build.with? "config-file"
  end
end
